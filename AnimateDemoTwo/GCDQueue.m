//
//  GCDQueue.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "GCDQueue.h"
#import "GCDGroup.h"

static GCDQueue *mainQueue;
static GCDQueue *globalQueue;
static GCDQueue *highPriorityGlobalQueue;
static GCDQueue *lowPriorityGlobalQueue;
static GCDQueue *backgroundPriorityGlobalQueue;

@interface GCDQueue ()

@property(nonatomic, strong, readwrite) dispatch_queue_t dispatchQueue;

@end

@implementation GCDQueue

#pragma mark  -队列
+ (GCDQueue *)mainQueue{
    return mainQueue;
}

+ (GCDQueue *)globalQueue{
    return globalQueue;
}

+ (GCDQueue *)highPriorityGlobalQueue{
    return highPriorityGlobalQueue;
}

+ (GCDQueue *)lowPriorityGlobalQueue{
    return lowPriorityGlobalQueue;
}

+ (GCDQueue *)backgroundPriorityGlobalQueue{
    return backgroundPriorityGlobalQueue;
}

+ (void)initialize
{
    if (self == [GCDQueue self]) {
        mainQueue = [GCDQueue new];
        globalQueue = [GCDQueue new];
        highPriorityGlobalQueue = [GCDQueue new];
        lowPriorityGlobalQueue = [GCDQueue new];
        backgroundPriorityGlobalQueue = [GCDQueue new];
        
        //创建不同的队列
        
        //主线程
        mainQueue.dispatchQueue = dispatch_get_main_queue();
        
        //默认优先级 在low之前，在high之后
        globalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        //优先级最高，在default和low之前执行
        highPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        //在high和default后执行
        lowPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        
        //提交到这个队列的任务会在high优先级的任务和已经提交到background队列的执行完成后执行
        backgroundPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

- (instancetype)init
{
    return [self initSerial];
}


- (instancetype)initSerial{
    if (self = [super init]) {
        /*
         * queue分为两种
         * 1.Serial Dispatch Queue 每次执行一个任务，按顺序
         * 2.Concurrent Dispatch Queue，任务并行执行，顺序不定。
         * 
         * 创建Queue
         * 就是用dispatch_queue_create("org.itjoy.gcd", NULL)
                dispatch_queue_create("org.itjoy.gcd.myConcurrent", DISPATCH_QUEUE_CONCURRENT)
         
         * 注意事项:
         * 使用dispatch_queue_create创建Serial Dispatch Queue,该queue虽然每次只执行一个任务，但是通过dispatch_queue_create可以创建多个Serial Dispatch Queue， 将处理追加到多个queue中，每次就同时执行多个任务，系统对于一个Serial Dispatch Queue就生成一个线程，如果这样的线程过多，对资源耗费是相当大的，反而降低了系统的性能，因此需要注意创建的数量
         
            对于共享数据的操作，应该使用Serial Dispatch Queue 这样不会造成数据竞争，生成脏数据。生成的Serial Dispatch Queue个数仅当所必需的数量。例如数据库创建表需要一个，文件写入需要一个，切忌不能大量创建
         
            当数据不发生数据竞争的时候可以使用Concurrent Dispatch Queue，对于该Queue,不管生成多少线程，都受系统限制，系统会回收不用的线程，相对于Serial Dispatch Queue问题要少
         */
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initSerialWithLabel:(NSString *)label{
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initConcurrent{
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initConcurrentWithLabel:(NSString *)label{
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


- (void)execute:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(self.dispatchQueue, block);
}

- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), self.dispatchQueue, block);
}

- (void)execute:(dispatch_block_t)block afterDelaySecs:(float)delta{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta * NSEC_PER_SEC), self.dispatchQueue, block);
}

- (void)waitExecute:(dispatch_block_t)block{
    //作为一个建议，这个方法尽量在当前线程池中调用
    NSParameterAssert(block);
    dispatch_sync(self.dispatchQueue, block);
}

- (void)barrierExecute:(dispatch_block_t)block{
    //使用的线程池应该是你自己创建的并发线程池，如果你传进来的参数为串行线程池，或者是系统的并发线程池中的某一个，这个方法就会被当做一个普通的async操作
    NSParameterAssert(block);
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)waitBarrierExecute:(dispatch_block_t)block{
    //使用的线程池应该是你自己创建的并发线程池，如果你传进来的参数为串行线程池或者是系统的并发线程池中的某一个，这个方法就会被当做一个普通的sync操作
    //作为一个建议，这个方法尽量在当前线程池中调用
    
    NSParameterAssert(block);
    dispatch_barrier_sync(self.dispatchQueue, block);
}

- (void)suspend{
    dispatch_suspend(self.dispatchQueue);
}

- (void)resume{
    dispatch_resume(self.dispatchQueue);
}

- (void)execute:(dispatch_block_t)block inGroup:(GCDGroup *)group{
    NSParameterAssert(block);
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(GCDGroup *)group{
    NSParameterAssert(block);
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}


#pragma mark -便利构造器
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec{
    //断言评估一个条件
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *sec), mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *sec), globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *sec), highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *sec), lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec{
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *sec), backgroundPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInMainQueue:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block{
    NSParameterAssert(block);
    dispatch_async(backgroundPriorityGlobalQueue.dispatchQueue, block);
}







@end

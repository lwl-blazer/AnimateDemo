
//
//  ZYPerson.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ZYPerson.h"

static NSString *_name;
static dispatch_queue_t _queue;
static dispatch_queue_t _currentQueue;

@implementation ZYPerson

/*
 * 涉及并发中的数据竞争时，书本上提到的一种解决方案。如果有多个线程要执行同一份代码，那么有时候可能会出现问题，解决方法如下:
 * 1.通常要使用锁来实现某种同步机制。iOS提供了一种加锁的方式，就是采用内置的synchronizer block，
 * 2.使用GCD可以简单高效的代替同步块或者锁对象，可以使用串行同步队列，将读操作以及写操作都安排在同一个队列里，即可保证数据同步
 * 3.多个getter方法(也就是读取)是可以并发执行的，而getter(读)与setter(写)方法是不能并发执行的，利用这个特点，还能写出更快的代码为，这次不用串队列，而改用并行队列
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_SERIAL);
        _currentQueue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

//第一种方法:
//- (void)setName:(NSString *)name{
//    /*
//     * 这种锁的方法会根据给定的对象，自动创建一个锁，并等待块中的代码执行完毕。执行这段代码结尾处，锁也就释放了。在这里同步行为所针对的对象是self.这种写法不会错，但是会大大降低代码效率，甚至很多时候，还可以被人感觉到效率明显下降。因为共同同一个锁的那些同步块，都必按顺序执行。若在self对象上频繁加锁，那么程序可能就要等另一段与此无关的代码执行完毕，才可以继续执行当前代码，这样做是很没有必要的
//     */
//    @synchronized (self) {
//        _name = [name copy];
//    }
//}
//
//- (NSString *)name{
//    @synchronized (self) {
//        return _name;
//    }
//}

//第二种方法
//- (void)setName:(NSString *)name{
//    /*
//     * 把写操作和读操作都安排在同一个同步串行队列里执行，这样的话，所有针对属性的访问操作就都同步了。
//     * 这种方法的确已经足够好了，但还不是最优的，它只可以实现单读，单写，整体来看，我们最终要解决的问题是，在写的过程中不能被读，以免数据不对，但是读与读之间并没有任何的冲突
//     */
//    dispatch_sync(_queue, ^{
//        _name = [name copy];
//    });
//}
//
//- (NSString *)name{
//    __block NSString *tempName;
//    dispatch_sync(_queue, ^{
//        tempName = _name;
//    });
//    return tempName;
//}


//第三种方法
- (void)setName:(NSString *)name{
    /*
     * 这样的写法，测试一下性能，可以发现这种做法肯定比使用串行队列要快
     * dispatch_barrier_async可以翻译成栅栏(barrier)，它可以往队列里面发送任务(块）这个任务有栅栏(barrier)的作用
     * 在队列中，barrier块必单独执行，不能与其他block并行，这只对并发队列有意义，并发队列如果发现接下来要执行的block是一个barrier block，那么就一直要等到当前所有并发的block都执行完毕，才会单独执行这个barrier block代码块，等到这个barrier block执行完毕，再继续正常处理其他并发block,在下面的代码中，setter方法中使用了barrier block以后，对象的读取操作依然是可以并发执行的，但是写入操作就必须单独执行了
     */
    dispatch_barrier_async(_currentQueue, ^{
        _name = name;
    });
}

- (NSString *)name{
    __block NSString *tempName;
    dispatch_sync(_currentQueue, ^{
        tempName = _name;
    });
    return tempName;
}

/*
 * 附加信息:
 *
 * 并行:就是队列里面的任务(代码块block)不是一个个执行，而是并发执行，也就是可以同时执行的意思
 * 串行:队列里面的任务一个接着一个执行，要等前一个任务结束，下一个任务才可以执行
 * 异步:具有新开线程的能力
 * 同步:不具有新开线程的能力，只能在当前线程执行任务
 
 * 那么如果他们相互串起来，会怎么样呢
 * 并行+异步: 就是真正的并发，新开有多个线程处理任务，任务并发执行(不按顺序执行)
 * 串行+异步: 新开一个线程，任务一个接一个执行，上一个任务处理完毕，下一个任务才可以被执行
 * 并行+同步: 不新开线程，任务一个接一个执行
 * 串行+同步: 不新开线程，任务一个接一个执行
 */

@end

//
//  GroupImageViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "GroupImageViewController.h"

@interface GroupImageViewController ()

@end

@implementation GroupImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self operation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)operation{
    [self group];
}


- (void)group{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第一张图片");
        //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://images2015.cnblogs.com/blog/471463/201509/471463-20150912213125372-589808688.png"]];
        NSLog(@"第一张图片下载完成");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第二张图片");
       // NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://images2015.cnblogs.com/blog/471463/201509/471463-20150912212457684-585830854.png"]];
        NSLog(@"第二张图片下截完成");
    });

    dispatch_group_notify(group, queue, ^{
        NSLog(@"合成");
    });

}



@end

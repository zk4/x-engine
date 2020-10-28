//
//  ZKLogViewController.m
//  motherboard
//
//  Created by 李宫 on 2020/10/23.
//  Copyright © 2020 zk. All rights reserved.
//

#import "ZKLogViewController.h"

@interface ZKLogViewController ()

@end

@implementation ZKLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XcodeInfo.txt"];
    //这里删除文件是为了避免在之前的文件上累加这次运行的日志
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:path error:nil];
    freopen([path cStringUsingEncoding:NSASCIIStringEncoding],"a+", stderr);

}




@end

//
//  OneViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OneViewController.h"
#import "iDirectManager.h"
#import "XENativeContext.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat tabBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect rect = CGRectMake(0, statusHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBarHeight);
    [XENP(iDirectManager) addToTab:self uri:@"microapp://todo" params:@{@"hideNavbar":@TRUE} frame:rect];

}
@end

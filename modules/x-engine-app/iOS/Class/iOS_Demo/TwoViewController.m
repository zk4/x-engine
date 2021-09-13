//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "TwoViewController.h"
#import <iDirectManager.h>
#import <XENativeContext.h>

@interface TwoViewController ()
@end


@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块2";
//    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.zkty.microapp.min11e" params:@{@"hideNavbar":@TRUE,@"nativeParams":@{@"__fallback__":@"microapp://com.zkty.microapp.home"}}];
//    [XENP(iDirectManager) addFallbackRouter:@"microapp://microapp.demo" fallback:@"http://www.baidu.com"];
//    [XENP(iDirectManager) addToTab:self uri:@"microapp://microapp.demo" params:@{@"hideNavbar":@TRUE}];
    [XENP(iDirectManager) addToTab:self uri:@"microapp://microapp.demo" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];

}
@end

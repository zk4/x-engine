//
//  ThreeViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "ThreeViewController.h"
#import <iDirectManager.h>
#import <XENativeContext.h>
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>


//#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>


@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本地bundle加载reactnative
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"bundle/index.jsbundle" withExtension:nil];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:url moduleName:@"App" initialProperties:nil launchOptions:nil];
//    rootView.frame = self.view.frame;
//    [self.view addSubview:rootView];
    
    // 本地地址加载rn
    [XENP(iDirectManager) push:@"lrn://bundle/index.jsbundle"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"App"}} frame:[UIScreen mainScreen].bounds];
}
@end

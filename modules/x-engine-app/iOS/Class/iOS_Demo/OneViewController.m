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
    // 这个里面侧边栏支持手势,
//    [XENP(iDirectManager) addToTab:self uri:@"https://uppy.io/examples/xhrupload" params:@{@"hideNavbar":@TRUE}];
    
    [XENP(iDirectManager) addToTab:self uri:@"http://10.2.128.71:8081" params:@{@"hideNavbar":@TRUE}];

    
//    [XENP(iDirectManager) addToTab:self uri:@"http://uat.c.gomedc.com/gm-appc-home/index.html" params:@{@"hideNavbar":@TRUE}];

}
@end

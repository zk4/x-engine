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
//    [XENP(iDirectManager) addToTab:self uri:@"https://uppy.io/examples/xhrupload" params:@{@"hideNavbar":@TRUE}];
    
    [XENP(iDirectManager) addToTab:self uri:@"http://192.168.1.15:8080" params:@{@"hideNavbar":@TRUE}];

    
//    [XENP(iDirectManager) addToTab:self uri:@"http://uat.c.gomedc.com/gm-appc-home/index.html" params:@{@"hideNavbar":@TRUE}];

}
@end

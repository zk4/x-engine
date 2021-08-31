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
    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.80:8080" params:@{@"hideNavbar": @TRUE} frame:[UIScreen mainScreen].bounds];
}
@end

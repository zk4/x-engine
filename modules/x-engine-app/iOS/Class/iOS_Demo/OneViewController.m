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

    [XENP(iDirectManager) addToTab:self uri:@"microapp://todo" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];

}
@end

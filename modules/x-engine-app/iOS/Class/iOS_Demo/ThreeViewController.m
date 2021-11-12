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


//#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>


@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.test.microapp.home.0" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}
@end

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
//    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.61:8080" params:@{@"hideNavbar":@TRUE}];
//    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.88:9111" params:nil frame:@{@"hideNavbar":@TRUE}];
//    [XENP(iDirectManager) addToTab:self uri:@"omp://10.2.128.88:9111" params:@{@"hideNavbar":@TRUE}];
//    [XENP(iDirectManager) addToTab:self uri:@"microapp://todo" params:@{@"hideNavbar":@TRUE}];
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];

        [director push:@"omp" host:@"10.2.128.91:8080" pathname:@"" fragment:@"/" query:nil params:@{@"hideNavbar":@YES}];

}
@end

//file:///var/mobile/Containers/Data/Application/14BE590E-8972-4A6E-9679-E3CF0440CDCF/Documents/com.gm.microapp.home.1/index.html

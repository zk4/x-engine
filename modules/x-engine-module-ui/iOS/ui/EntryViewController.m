//
//  EntryViewController.m
//  ui
//
//  Created by edz on 2020/7/22.
//  Copyright © 2020 edz. All rights reserved.
//

#import "EntryViewController.h"
#import <XEngineContext.h>
//#import <MircroAppController.h>
#import <x-engine-module-engine/XEOneWebViewControllerManage.h>

//#import <UIViewController+.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
 
    [self pushTestModule];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
}
 
-(void) pushTestModule{
    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://10.2.128.80:9111"];
}

@end

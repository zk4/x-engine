//
//  TwoViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
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


    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.gm.microapp.mine" params:@{@"hideNavbar":@TRUE, @"onTab":@TRUE}];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"............");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

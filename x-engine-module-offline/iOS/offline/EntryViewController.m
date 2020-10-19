//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import <UIViewController+Push_Present.h>
#import <MircroAppController.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (IBAction)Action2:(id)sender {
    [self pushTestModule2];
}

- (void)pushTestModule {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.pullDownRefresh"];
    webLaderVC.navigationItem.title = @"pulldownrefresh";
    [self pushViewController:webLaderVC];
}

- (void)pushTestModule2 {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.device" ];
    webLaderVC.navigationItem.title = @"device";
    [self pushViewController:webLaderVC];
}
@end

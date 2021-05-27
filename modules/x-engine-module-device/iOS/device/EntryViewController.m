//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
//#import <MircroAppController.h>
//#import <UIViewController+.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "XEOneWebViewControllerManage.h"

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}



-(void) pushTestModule{
    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://192.168.1.116:8080"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

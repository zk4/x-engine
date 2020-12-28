//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"

#import <x-engine-module-engine/XEOneWebViewControllerManage.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://192.168.1.106:9111"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

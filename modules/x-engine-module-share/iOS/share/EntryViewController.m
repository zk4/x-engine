//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import <x-engine-module-engine/XEOneWebViewControllerManage.h>
 
 
 
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}
 
-(void) pushTestModule{
    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://172.20.10.10:9111"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

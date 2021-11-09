//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (void)pushTestModule{
    [XENP(iDirectManager) push:@"rn://localhost:8081/index.bundle?platform=ios" moduleName:@"App" params:@{@"hideNavbar":@TRUE} frame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

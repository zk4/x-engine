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

-(void) pushTestModule{
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
  
    [director push:@"omp://192.168.1.15:8080" params:@{@"hideNavbar":@YES}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end
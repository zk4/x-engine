//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "iDirectManager.h"
#import "XENativeContext.h"
 
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    [director push:@"omp" host:@"10.2.128.91:9111" pathname:@"" fragment:@"/" query:nil params:@{@"hideNavbar":@YES}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

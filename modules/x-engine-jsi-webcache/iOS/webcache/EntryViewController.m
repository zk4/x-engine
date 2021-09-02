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
  
    [director push:@"omp://10.2.128.127:9111" params:@{@"hideNavbar":@YES}];
//    [director push:@"https://www.baidu.com" params:@{@"hideNavbar":@YES}];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

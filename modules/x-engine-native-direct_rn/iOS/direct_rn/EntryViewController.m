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
    
//    [director push:@"rn" host:@"192.168.1.15:8081" pathname:@"/index.bundle"  fragment:nil query:@{@"platform":@"ios"}  params:@{
//        @"scores" : @[
//          @{
//            @"name" : @"Alex",
//            @"value": @"42"
//           },
//          @{
//            @"name" : @"Joel",
//            @"value": @"10"
//          }
//        ]
//      }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

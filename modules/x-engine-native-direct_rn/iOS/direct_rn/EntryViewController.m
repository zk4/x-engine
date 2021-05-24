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
    id<iDirectManager> director = XENP(iDirectManager);
 
    [director push:@"rn" host:@"192.168.1.15:8081" pathname:@"/index.bundle"  fragment:nil query:@{@"platform":@"ios"}  params:@{
        @"scores" : @[
          @{
            @"name" : @"Alex",
            @"value": @"42"
           },
          @{
            @"name" : @"Joel",
            @"value": @"10"
          }
        ]
      }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
  

}

@end

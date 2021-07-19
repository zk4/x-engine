//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"

#import "XENativeContext.h"
#import "MGJRouter.h"
#import <iDirectManager.h>

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iDirectManager>  dm = XENP(iDirectManager);
    [dm push:@"native://foo/bar?user_id=1900" params:nil];
//    [MGJRouter openURL:@"native://foo/bar?user=2#a=3" withUserInfo:@{
//        @"query": @{@"user_id":@1900},
//        @"params": @{@"hideNavBar":@TRUE}
//    }  completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 


}

@end

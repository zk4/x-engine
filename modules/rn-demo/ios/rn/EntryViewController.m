//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#import <React/RCTRootView.h>
//#import <React/RCTBundleURLProvider.h>

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}
 
-(void) pushTestModule{
      NSLog(@"High Score Button Pressed");
      NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];

      RCTRootView *rootView =
        [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                    moduleName: @"RNHighScores"
                             initialProperties:
                               @{
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
                               }
                                 launchOptions: nil];
      UIViewController *vc = [[UIViewController alloc] init];
      vc.view = rootView;
      [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self pushTestModule];
}

@end

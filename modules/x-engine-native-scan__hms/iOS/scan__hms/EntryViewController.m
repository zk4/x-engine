//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iScan.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iScan> scan =XENP(iScan);
    [scan openScanView:^(NSString *res) {
        NSLog(@"%@", res);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end

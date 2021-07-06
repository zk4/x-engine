//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iDev.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
    id<iDev> dev = XENP(iDev);
    [dev enabledDebug:TRUE];
    [dev log:@"world"];

}

@end

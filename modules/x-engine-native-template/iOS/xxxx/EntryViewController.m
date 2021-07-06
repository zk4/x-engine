//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iUI.h>
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
    id<iUI> ui = XENP(iUI);
    [ui alert:@"world"];

}

@end

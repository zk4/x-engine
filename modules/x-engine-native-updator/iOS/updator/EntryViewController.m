//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iDirectManager.h>
#import "iUpdator.h"

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    [XENP(iDirectManager) push:@"microapp://com.gm.microapp.home" params:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self pushTestModule];
//    [XENP(iDirectManager) push:@"microapp://com.gm.microapp.home" params:nil];
    [XENP(iUpdator) updateMicroappsFromUrl:@"http://localhost:9527/data.json"];
}

@end

//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <iDirectManager.h>

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iDirectManager>  dm = XENP(iDirectManager);
    [dm push:@"native://foo/bar2" params:@{@"hello":@"world"}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 


}

@end

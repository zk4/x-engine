//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "NativeContext.h"
 
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

}

@end

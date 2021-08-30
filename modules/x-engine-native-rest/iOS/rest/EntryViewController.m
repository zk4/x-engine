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
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

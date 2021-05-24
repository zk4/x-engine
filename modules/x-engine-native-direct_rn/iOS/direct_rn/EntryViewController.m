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

    [director push:@"rn" host:@"category" pathname:@"/Two"  fragment:@"" query:nil  params:@{@"hideNavbar":@TRUE}];

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
  

}

@end

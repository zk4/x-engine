//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "NativeContext.h"
#import "Native_store.h"
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
   id<iStore> store =  XENP(iStore);
//[store set:@"haha" val:@"yes"];

   id a =[store get:@"haha" ];
    NSLog(@"%@",a);


}

@end

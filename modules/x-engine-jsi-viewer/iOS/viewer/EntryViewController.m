//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "iViewer.h"
@interface EntryViewController ()
@property(nonatomic,strong) id<iViewer> iviewer;

@end

@implementation EntryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

- (void)pushTestModule {
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    [director push:@"omp" host:@"10.2.128.61:9111" pathname:@"" fragment:@"/" query:nil params:@{@"hideNavbar":@YES}];
}

- (IBAction)Action:(id)sender {
    [self pushTestModule];
}
@end

//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "iGmshare.h"
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iGmshare> igmshare = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iGmshare)];
//    OpenShareUiDTO *openShare = [OpenShareUiDTO new];
    
//    [igmshare openShareUi:openShare complete:^(ChannelStatusDTO * _Nonnull y, BOOL s) {
//        NSLog(@"----");
//    }];
//    [director push:@"omp" host:@"192.168.1.15:9111" pathname:@"" fragment:@"/" query:nil params:@{@"hideNavbar":@YES}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

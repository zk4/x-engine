//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirect.h"
#import "iScan.h"
@interface EntryViewController ()
@property(nonatomic,strong) id<iDirect> nativeDirect;
@property (nonatomic, strong) id<iScan>  nativeScan;
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    [self.nativeDirect push:@"" host:@"" pathname:@"mgj://scan/scan" fragment:@"/" query:nil params:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
    _nativeDirect = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirect)];

    __weak typeof(self) weakSelf = self;
    [_nativeDirect registerURLPattern:@"mgj://scan/scan" openNativeActive:^{
        weakSelf.nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
        [weakSelf.nativeScan openScanView:^(NSString *res) {
            NSLog(@"扫码结果 %@",res);
        }];
    }];
    
}

@end

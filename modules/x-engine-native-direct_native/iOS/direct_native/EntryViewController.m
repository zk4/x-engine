//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirect.h"
#import "iScan.h"
#import "Unity.h"

@interface EntryViewController ()
@property(nonatomic,strong) id<iDirect> nativeDirect;
@property (nonatomic, strong) id<iScan>  nativeScan;
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
//    [self pushTestModule];
}

-(void) pushTestModule{
    [self.nativeDirect push:@"" host:@"" pathname:@"/scan/scan" fragment:@"/" query:nil params:@{@"key":@"value"}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
//    _nativeDirect = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirect)];
//
//    __weak typeof(self) weakSelf = self;
//    [_nativeDirect registerURLPattern:@"/scan/scan" openNativeActive:^(NSDictionary *routerParameters){
//        weakSelf.nativeScan = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iScan)];
//        [weakSelf.nativeScan openScanView:^(NSString *res) {
//            NSLog(@"扫码结果 %@",res);
//        }];
//        NSDictionary *dict = routerParameters[@"MGJRouterParameterUserInfo"];
//        UIAlertController *ac = [UIAlertController alertControllerWithTitle:dict[@"key"] message:@"与啊谁呢好难过" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        [ac addAction:action];
//        [[Unity sharedInstance].getCurrentVC presentViewController:ac animated:YES completion:nil];
//    }];
    
}

@end

//
//  Native_hms_scan.m
//  hms_scan
//


#import "Native_hms_scan.h"
#import "XENativeContext.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>
#include <Unity.h>
 
typedef void (^xScanBlock)(NSString *);
@interface Native_hms_scan()
 
    @property ( nonatomic) xScanBlock block;
 
@end

@implementation Native_hms_scan
NATIVE_MODULE(Native_hms_scan)

 - (NSString*) moduleId{
    return @"com.zkty.native.hms_scan";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
 
- (void)openScanView:(void (^)(NSString *))completionHandler {
    // 初始化HmsDefaultScanViewController，实现代理。
    // "QR_CODE | DATA_MATRIX"表示只扫描QR和DataMatrix的码
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:QR_CODE | DATA_MATRIX Photo:FALSE];
    HmsDefaultScanViewController *hmsDefaultScanViewController = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
    
    hmsDefaultScanViewController.defaultScanDelegate = self;
    [[Unity sharedInstance].getCurrentVC.view addSubview:hmsDefaultScanViewController.view];
    [[Unity sharedInstance].getCurrentVC addChildViewController:hmsDefaultScanViewController];
    [[Unity sharedInstance].getCurrentVC didMoveToParentViewController:hmsDefaultScanViewController];
 
   // 隐藏导航栏。
    [Unity sharedInstance].getCurrentVC.navigationController.navigationBarHidden = YES;
    self.block = completionHandler;
}
/*DefaultScan Delegate
  Data returned by code scanning
 */
- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic{
    NSString* jsonStr=  resultDic[@"text"];
    self.block(jsonStr?jsonStr:@"");
}

/*DefaultScan Delegate
  Data returned by album pictures
 */
- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
   // TODO: iScan 没这个功能
}
@end
 

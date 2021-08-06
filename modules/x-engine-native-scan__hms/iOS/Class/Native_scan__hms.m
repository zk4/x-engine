//
//  Native_scan__hms.m
//  scan__hms
//


#import "Native_scan__hms.h"
#import "XENativeContext.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>
#include <Unity.h>
 
typedef void (^xScanBlock)(NSString *);
@interface Native_scan__hms()
 
    @property ( nonatomic) xScanBlock block;
@property (nonatomic, strong) HmsDefaultScanViewController * hms_vc;

@end

@implementation Native_scan__hms
NATIVE_MODULE(Native_scan__hms)

 - (NSString*) moduleId{
    return @"com.zkty.native.scan__hms";
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
    HmsDefaultScanViewController* hms_vc = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
//    全屏
//    hms_vc.modalPresentationStyle = UIModalPresentationFullScreen;
    hms_vc.defaultScanDelegate = self;
    [[Unity sharedInstance].getCurrentVC presentViewController:hms_vc animated:YES completion:^{
        
    }];
 
   // 隐藏导航栏。
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
 

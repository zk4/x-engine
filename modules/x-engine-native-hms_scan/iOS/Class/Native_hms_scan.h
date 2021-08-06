//
//  Native_hms_scan.h
//  hms_scan
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import <iScan.h>
#import <ScanKitFrameWork/ScanKitFrameWork.h>

NS_ASSUME_NONNULL_BEGIN
@interface Native_hms_scan : XENativeModule <iScan,DefaultScanDelegate>
 
@end

NS_ASSUME_NONNULL_END

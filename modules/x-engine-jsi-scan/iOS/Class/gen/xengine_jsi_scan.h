
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol _openScanView_com_zkty_jsi_scan_0_DTO;
@class _openScanView_com_zkty_jsi_scan_0_DTO;

@interface _openScanView_com_zkty_jsi_scan_0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* routerUrl;
@end



@protocol xengine_jsi_scan_protocol
   @required 
     - (void) _openScanView:(_openScanView_com_zkty_jsi_scan_0_DTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;
     - (void)_openScanView:(void (^)(NSString* result,BOOL complete)) completionHandler;
@end



@interface xengine_jsi_scan : JSIModule<xengine_jsi_scan_protocol>
@end



// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_scan.h"


@implementation _openScanView_com_zkty_jsi_scan_0_DTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"routerUrl"]) { return YES; }	return NO;
}
@end





@implementation xengine_jsi_scan
- (instancetype)init
{
    self = [super init];
    return self;
}

- (NSString *)moduleId{
    return @"com.zkty.jsi.scan";
}
- (void) openScanView:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    
    if (dict && dict.allKeys.count>0) {
        _openScanView_com_zkty_jsi_scan_0_DTO* dto = [self convert:dict clazz:_openScanView_com_zkty_jsi_scan_0_DTO.class];

        if(!dto) {
            [self showErrorAlert: @"dto 转换为空"];
            return;
        }

        [self _openScanView:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
        }];
    }else{
        [self _openScanView:^(NSString *result, BOOL complete) {
            completionHandler(result,complete);
        }];
    }
    
}
@end

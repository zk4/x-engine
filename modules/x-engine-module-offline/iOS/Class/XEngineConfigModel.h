//
//  XEngineConfigModel.h

#import "JSONModel.h"

@interface XEngineConfigModel : JSONModel
    @property (nonatomic, copy) NSString *appId;
    @property (nonatomic, copy) NSString *offlineServerUrl;
    @property (nonatomic, copy) NSString *appSecret;
@end



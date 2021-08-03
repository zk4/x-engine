//
//  iOffline.h
//  Offline
//

#ifndef iOffline_h
#define iOffline_h
@protocol iOffline <NSObject>

/**
 * 离线包
 * @url 请求后台地址
 */
- (void)offlinePackageWithUrl:(NSString *)url;

@end
#endif /* iOffline_h */

//
//  iOffline.h
//  Offline
//

#ifndef iOffline_h
#define iOffline_h
@protocol iOffline <NSObject>
/// 请求包信息
/// @param url 请求地址
/// return 接口请求的信息
- (void)getPackagesInfo:(NSString *)url completion:(void(^)(NSArray *array))arrayBlock;


/// 判断是否需要下载新的应用包
/// @param packageInfo 从后台请求的所有包信息
/// return 返回ture 、false
- (void)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo completion:(void (^)(BOOL, NSDictionary *dict))isDownloadBlock;


/// 下载新的应用包
- (void)downloadNewPackageWithDict:(NSDictionary *)dict;
@end
#endif /* iOffline_h */

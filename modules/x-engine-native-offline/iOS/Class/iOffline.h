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

/**
 * 获取微应用包地址
 * @packageName: 需要加载包名称
 */
- (NSString *)getPackageWithPackageName:(NSString *)packageName;
@end
#endif /* iOffline_h */

//
///**
// * 读取根目录下packageInfo.json的内容
// * @array all local microapp 集合
// */
//- (NSDictionary *)getRootPackageJsonInfo;
//
///**
// * 将项目下的microoapp信息存入document
// * @array all microapp 集合
// */
//- (void)saveProjectMicroappInfo:(NSDictionary *)dict;
//
///**
// * 从document读取存入的microoapp信息
// * return all microapp info
// */
//- (NSDictionary *)getProjectMicroappInfo;
//
//
///**
// * 请求包信息
// * @param url 请求地址
// * return 接口请求的信息
// */
//- (void)getPackagesInfo:(NSString *)url completion:(void(^)(NSArray *array))arrayBlock;
//
//
///**
// *  判断是否需要下载新的应用包
// *  @param packageInfo 从后台请求的所有包信息
// *  return 返回ture 、false
// */
//- (void)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo completion:(void (^)(BOOL, NSDictionary *dict))isDownloadBlock;
//
//
///**
// * 下载新的应用包
// *  @param dict 当前应用包的信息
// */
//- (void)downloadNewPackageWithDict:(NSDictionary *)dict;

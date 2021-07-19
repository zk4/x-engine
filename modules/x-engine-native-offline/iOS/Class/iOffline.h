//
//  iOffline.h
//  Offline
//

//response: -->
//    data:[
//        {
//            // false 不强制更新  ture 强制更新
//            // 不强制更新 ==> 最新的包更新完后不管
//            // 强制更新 ==> 最新的包更新完后就用最新的包刷新页面
//            isForce: false,
//            packageVersion: 0,
//            packageName: "com.gm.microapp.home"
//            downloadUrl:"https://www.baidu.com",
//        },
//        {
//            // false 不强制更新  ture 强制更新
//            // 不强制更新 ==> 最新的包更新完后不管
//            // 强制更新 ==> 最新的包更新完后就用最新的包刷新页面
//            isForce: false,
//            packageVersion: 0,
//            packageName: "com.gm.microapp.home"
//            downloadUrl:"https://www.baidu.com",
//        }
//   ]

#ifndef iOffline_h
#define iOffline_h
@protocol iOffline <NSObject>

/// 请求包信息
/// @param url 请求地址
/// return 接口请求的信息
- (NSArray *)getPackagesInfo:(NSString *)url;


/// 判断是否需要下载新的应用包
/// @param packageInfo 从后台请求的所有包信息
/// return 返回ture 、false
- (BOOL)judgeIsDownloadNewPackage:(NSDictionary *)packageInfo;


/// 下载新的应用包
/// @param downloadURL 下载地址
/// return 返回ture 、false
- (BOOL)downloadNewPackage:(NSString *)downloadURL;
@end
#endif /* iOffline_h */

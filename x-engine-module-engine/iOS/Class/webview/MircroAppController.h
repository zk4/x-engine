//
//  WebFileUrlViewController.h

#import "XEOneRecyleWebViewController.h"



@interface MircroAppController : XEOneRecyleWebViewController


/// 自动加载最新版本微应用
/// @param microappId 微应用id
- (instancetype)initWithMicroAppId:(NSString *)microappId;


- (instancetype)initWithMicroAppId:(NSString *)microappId route:(NSString*)path;
/// 加载指定版本微应用
/// @param microappId 微应用id
/// @param version 微应用版本
//- (instancetype)initWithMicroAppId:(NSString *)microappId microappVersion:(NSString*) version;


//- (instancetype)initWithPreLevelPath:(NSString *)preLevelPath;

- (instancetype)initWithUrl:(NSString *) fileUrl;

//- (instancetype) initWith:(NSString*)scheme host:(NSString*)host port:(NSNumber*)port path:(NSString*)path query:(NSString*)query  fragment:(NSString*) fragment;

//-(void)loadFileUrl:(NSString *)url query:(NSString *)query;
/*
 * 加载条背景颜色
 * 16进制色值
 */
@property (nonatomic, copy) NSString *progressBackgroundColor;
@end



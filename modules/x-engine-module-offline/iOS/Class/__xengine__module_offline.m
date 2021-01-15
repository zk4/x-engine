//
//  __xengine__module_offline.m

#import "__xengine__module_offline.h"
#import "XEngineConfigModel.h"

//#import "xengine_protocol_network.h"
//#import "XEngineContext.h"
//#import "MicroAppLoader.h"
#import <x-engine-module-protocols/xengine_protocol_network.h>
#import <x-engine-module-engine/XEngineContext.h>
#import <x-engine-module-engine/MicroAppLoader.h>
#import <x-engine-module-tools/XEZipUtil.h>
#import <x-engine-module-tools/NSString+Extras.h>
//#import <SSZipArchive/SSZipArchive.h>
/*
 - 启动
 - 请求服务器获取 microApp.json getMicroAppJson()
 - 请求成功:
 - 循环:url,version = locateMicroAppByMicroappId
 - url != nil: 通过 appid 对比版本号
 - 本地版本低, 下载远程新版本,并解压到沙盒
 - 本地版本一样或更高, 返回
 - url 为 nil: 下载远程新版本,并解压到沙盒
 - 请求失败: 不做任何事
 
 
 
 - (url) locateMicroAppByMicroappId(&version)
 - 从沙盒找
 - 成功, 返回 index.html 位置与版本
 - 失败, 从工程找
 - 成功 返回 index.html 位置与版本
 - 失败 返回 (nil,-1)
 
 
 */

@interface __xengine__module_offline()
@property (nonatomic, strong) XEngineConfigModel* configModel;
@property (nonatomic, weak) id<xengine_protocol_network> network;
@property (nonatomic, copy) NSString *microAppsPath;
@property (nonatomic, strong) NSDictionary *localMicroAppDict;
@property (nonatomic, weak) MicroAppLoader *microAppLoader;
@end

@implementation __xengine__module_offline
- (NSString *)moduleId {
    return @"com.zkty.module.offline";
}

- (void)onAllModulesInited {
    _network = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(xengine_protocol_network)];
    _localMicroAppDict = [NSDictionary dictionary];
    self.microAppLoader = [MicroAppLoader sharedInstance];
    [self loadXengineConfig];
    [self getMicroAppJsonFromNet];
}
- (void) loadXengineConfig{
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"xengine_config"ofType:@"json"];
    if (!configPath) {
        [self showErrorAlert:@"no xengine_config.json in your project"];
        return;
    }
    NSData *JSONData = [NSData dataWithContentsOfFile:configPath];
    NSDictionary*dic;
    if (JSONData) {
        dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        self.configModel = [[XEngineConfigModel alloc] initWithDictionary:dic error:nil];
    } else {
        [self showErrorAlert:@"xengine_config.json parse error"];
    }
}
- (void) getMicroAppJsonFromNet {
    if(!self.configModel || !self.configModel.offlineServerUrl){
        [self showErrorAlert:@"xengine_config.json is not correct"];
    }
    
    NSString *key = [[NSString stringWithFormat:@"%@%@", self.configModel.appId, self.configModel.appSecret] md5HexDigest];
    NSString *downloadURL = [NSString stringWithFormat:@"%@%@?v=%ld&key=%@&engine_version=1", self.configModel.offlineServerUrl, @"/microApps.json",random(),key];
    NSLog(@"url:%@",downloadURL);
    
    [_network GET:downloadURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        NSDictionary * microapp_dict = responseObject;
        if(microapp_dict){
            id code =   microapp_dict[@"code"];
            if(!code || [code longValue]!=0) return;
            
            for (NSDictionary *dict in microapp_dict[@"data"]) {
                NSString *microAppID = dict[@"microAppId"];
                NSInteger microAppVersion =  [dict[@"microAppVersion"] longValue];
//                long cur_version;
                NSLog(@"remote:%@.%ld",microAppID, (long)microAppVersion);
                NSString* local_path = [self.microAppLoader locateMicroAppByMicroappId:microAppID in_version:0];
                if(!local_path ){//}|| cur_version < microAppVersion){
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.%ld.zip",self.configModel.offlineServerUrl, microAppID, (long)microAppVersion];
                    NSURL *URL = [NSURL URLWithString:urlStr];
                    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                    
                    NSURLSessionDownloadTask *downloadTask = [self.network downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                        
                    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                        if(error){
                            NSLog(@"zip download error. %@", error );
                        }
                        else{
                            [self unzipToSandBox: filePath];
                        }
                        
                        //even the url is not exist. file will be created eventually.
                        //delete the temp file
                        [[NSFileManager defaultManager] removeItemAtPath:[filePath path] error:NULL];
                        
                    }];
                    [downloadTask resume];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
    }];
}
-(void) unzipToSandBox:(NSURL*) filePath {
    
    NSString *folderName = [NSString stringWithFormat:@"microApps/%@",[[filePath lastPathComponent] stringByDeletingPathExtension]];
    
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:folderName];
    
    [XEZipUtil unzipFileAtPath:[filePath path] toDestination:path overwrite:YES password:nil progressHandler:nil completionHandler:^(NSString *path, BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"path:%@, error:%@", path,   error);
        }
        else{
            NSLog(@"unizp successful %@",path);
        }
    }];
}

+ (NSString *)microAppDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths lastObject] stringByAppendingPathComponent:@"microApps"];
}



// 页面的demo演示
- (void)showActionSheet:(NSString *)jsonString complate:(XEngineCallBack)completionHandler {
    
}
@end




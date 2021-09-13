//
//  Native_updator.m
//  updator
//


#import "Native_updator.h"
#import "XENativeContext.h"
#import "ZipArchive.h"
#import <iRest.h>
#import "AFHTTPSessionManager.h"
#import <Unity.h>
#import "iToast.h"

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#define kMicroapps @"microapps"

@implementation MicroappInfoDTO
@end
 
@interface Native_updator() <NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
    @property (nonatomic, strong) NSMutableDictionary<NSString*,MicroappInfoDTO*> * microappInfos;
@property (nonatomic, strong) id<iToast> toast;
@property (nonatomic, strong) AFHTTPSessionManager* manager;
@end

@implementation Native_updator
NATIVE_MODULE(Native_updator)

- (NSString *)moduleId {
    return @"com.zkty.native.updator";
}

- (int)order {
    return 0;
}


- (void)afterAllNativeModuleInited {
    _toast = XENP(iToast);
    
    self.manager = [AFHTTPSessionManager manager];
    [self.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [self.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
     self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"multipart/form-data", nil];

}
- (NSDictionary *)microappInfos {
    if (!_microappInfos) {
        _microappInfos = [NSMutableDictionary new];
      
        [self updateMicroappsInfos];
    }
    return _microappInfos;
}


- (void) updateMicroappsInfos{
    @synchronized (self) {
    // 1. 扫描工程文件夹 microapps
    NSString *prjRootMicroappsPath = [[NSBundle mainBundle] pathForResource:@"microapps" ofType:@""];
    NSMutableDictionary* prjDict = [self scanPath:prjRootMicroappsPath];
 
    [self.microappInfos addEntriesFromDictionary:prjDict];
            
    // 2. 扫描沙盒文件夹 {sandbox}/Documents/microapps
    NSString *sandboxMicroappPath= [NSString stringWithFormat:@"%@/microapps" ,kDocumentPath] ;
    NSMutableDictionary* sandboxDict =  [self scanPath:sandboxMicroappPath];

    // 3. MERGE
    [self mergeDictWithBiggerVersion:sandboxDict];

    }
}
- (void) mergeDictWithBiggerVersion:(NSMutableDictionary*) dict{
    for (id key in dict) {
        MicroappInfoDTO* newDto = dict[key];
        MicroappInfoDTO* oldDto = self.microappInfos[key];
        // old 不存在　或者　新　version　的比旧的大
        if(!oldDto || newDto.version  > oldDto.version){
            [self.microappInfos setObject:newDto forKey:key];
        }
        NSLog(@"%@",key);
    }
}
 

- (void) downloadMicroappToCache:(NSString*) downloadUrl {
     
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];

    NSURLSessionDownloadTask *downTask = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下载进度
            NSLog(@"%f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        NSString *fullPath = [targetPath.absoluteString stringByAppendingString:@".zip"];
        return [NSURL URLWithString:fullPath];
               
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(filePath && !error){
            (@"%@",filePath);

            [self unzipCacheZipToDocument:filePath.path];
        }
        else{
            [XENP(iToast) toast:[NSString stringWithFormat:@"下载失败: %@", downloadUrl]];
            NSLog(@"completionHandler----%@",error);
        }
    } ];
    [downTask resume];
}
- (void) unzipCacheZipToDocument:(NSString*) cachedZipUrl  {
    NSString* folderName =cachedZipUrl.lastPathComponent;
    
    NSString *UUID = [[NSUUID UUID] UUIDString];
    NSString *tmp_sandboxMicroappPath= [NSString stringWithFormat:@"%@/microapps/%@" ,kDocumentPath,UUID];
//    NSString *tmp_microappjsonFilePath= [NSString stringWithFormat:@"%@/microapps/%@/microapp.json" ,kDocumentPath,UUID];

    __weak __typeof(self)weakSelf = self;
    [SSZipArchive unzipFileAtPath:cachedZipUrl toDestination:tmp_sandboxMicroappPath progressHandler:nil completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (!error) {
                NSLog(@"解压成功%@",folderName);
                // 重命名文件夹 microappid.version
//                // TODO: 使用 microapp.json 里的版本号与 id
//                NSError * err = NULL;
//                NSFileManager * fm = [[NSFileManager alloc] init];
//
//                NSDictionary* microappjsonDict=  [self readMicroappjsonFile:tmp_microappjsonFilePath];
//                NSString* folderName =  microappjsonDict[@"id"];
//                NSInteger version =  [microappjsonDict[@"version"] intValue];
//                NSString *sandboxMicroappPath= [NSString stringWithFormat:@"%@/microapps/%@.%ld" ,kDocumentPath,folderName,version];
//
//                BOOL result = [fm moveItemAtPath:tmp_sandboxMicroappPath toPath:sandboxMicroappPath error:&err];
//                if(!result){
//                    NSString* msg = [NSString stringWithFormat:@"重命名失败:%@",err.localizedDescription];
//                    [strongSelf.toast toast:msg];
//                }
//                else{
//                    NSString* msg = [NSString stringWithFormat:@"%@ -> %@",tmp_sandboxMicroappPath,sandboxMicroappPath];
//                    [self toast:msg];
                    [self updateMicroappsInfos];
                    NSString* msg = [NSString stringWithFormat:@"%@ 安装成功,重新打开微应用将使用最新",folderName];
                    [strongSelf.toast toast:msg];
            
//                }
#ifdef DEBUG
                [strongSelf.toast toast:path];
#endif
           
            } else {
                NSString* msg = [NSString stringWithFormat:@"解压失败==>%@", error];
                [XENP(iToast) toast:msg];
            }
    }];
}

- (void)updateMicroappsFromUrl:(NSString *)url {

    [self.manager POST:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(responseObject && responseObject[@"data"]){
                for(id entry in responseObject[@"data"][@"list"]){
                    NSLog(@"%@",entry);
                    NSString* microappId = entry[@"microappId"];
                    MicroappInfoDTO* dto = [self.microappInfos objectForKey:microappId];
                    if(!dto){
                        NSString* downloadUrl = entry[@"downloadUrl"];
                        if(downloadUrl){
                            [self downloadMicroappToCache:downloadUrl];
                        } else {
                            NSLog(@"no download url");
                        }
                    }else{
                        NSInteger version = [entry[@"version"] intValue];
                        if(version > dto.version)
                        {
                       
                            NSString* downloadUrl = entry[@"downloadUrl"];
                            // TODO: 实现 force
                            BOOL force =  entry[@"isForce"]?[entry[@"isForce"] boolValue]:NO;
                            if(downloadUrl){
                                [self downloadMicroappToCache:downloadUrl];
                            } else {
                                NSLog(@"no download url");
                            }

                        }
                    }
                }
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
    }];
}




- (NSDictionary *)readMicroappjsonFile:(NSString *)microappJsonPath {
    NSData *data = [[NSData alloc] initWithContentsOfFile:microappJsonPath];
    if(!data) {
        NSArray* ary = [microappJsonPath componentsSeparatedByString:@"/"];
        NSString* packagename =[NSString  stringWithFormat:@"%@/%@", ary[ary.count-2], ary[ary.count-1]];
        NSString* msg = NULL;
        if([microappJsonPath containsString:@"/Documents/"]){
            msg= [NSString stringWithFormat:@"沙盒\n%@ 不存在",packagename];
        }else{
            msg= [NSString stringWithFormat:@"工程\n%@ 不存在",packagename];
        }
      
        // toggle queueing behavior
        [XENP(iToast) toast:msg];
        
        return nil;
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if(!dict) return nil;
    return dict;
}

/*
扫描路径 path 下的的 microapps 内的微应用
目录结构:
/microapps
   /com.zkty.xxx.xxx
       /microapp.json
*/
- (NSMutableDictionary<NSString*,MicroappInfoDTO*>*) scanPath:(NSString*) rootMicroappsPath {
    
    // 找到 rootPath 下所有文件夹
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootMicroappsPath error:nil];
    
    NSMutableDictionary<NSString*,MicroappInfoDTO*> * microappInfos=[NSMutableDictionary new];
    for (NSInteger i = 0; i < arr.count; i++) {
        // 找到 文件夹下所有的 microapp.json
        NSString *rootPath = [NSString stringWithFormat:@"%@/%@/",rootMicroappsPath, arr[i]];
        NSString *microappJsonPath = [NSString stringWithFormat:@"%@microapp.json",rootPath];
       
        NSDictionary * dict = [self readMicroappjsonFile:microappJsonPath];
        if(!dict) continue;
        NSInteger version =   [dict[@"version"] intValue];
        NSString* microappId = dict[@"id"] ;
        MicroappInfoDTO * dto = [MicroappInfoDTO new];
        dto.version = version;
        dto.microappId = microappId;
        dto.localpath = rootPath;
        dto.rawMicroappInfo = dict;
        MicroappInfoDTO* oldDto = [microappInfos objectForKey:microappId];
        if(!oldDto  || oldDto.version< version)
            [microappInfos setObject:dto forKey:microappId];
 
    }
    return microappInfos;
}
 
 
- (NSString*)getPath:(NSString*) microappId{
    if(self.microappInfos.count==0){
        [self updateMicroappsInfos];
    }
    
    MicroappInfoDTO* dto = self.microappInfos[microappId];
    if(dto){
        return dto.localpath;
    }
 
    return  nil;
}

@end

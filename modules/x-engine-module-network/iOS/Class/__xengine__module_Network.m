//
//  __xengine__module_NetworkModule.m
//  NSURLSessionDataTask
//

//#import "__xengine__module_Network.h"
//#import "XEngineContext.h"
//#import "micros.h"


#import "__xengine__module_Network.h"
#import <micros.h>
#import <x-engine-module-tools/NSString+Extras.h>
#import "RecyleWebViewController.h"
#import "Unity.h"
#import "XENetworkprotocol.h"
#import "XEAFNetwork4Util.h"
#import "XEUploadDataModel.h"

typedef void (^SuccessBlock)(NSURLSessionDataTask *, id);
typedef void (^FailBlock)(NSURLSessionDataTask *task, NSError *error);

@interface __xengine__module_Network()

@property (nonatomic, weak) id<XENetworkprotocol> network;
@end

@implementation __xengine__module_Network

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.network = [XEAFNetwork4Util instance];
    }
    return self;
}
- (NSString *)moduleId {
    return @"com.zkty.module.network";
}

- (void)_getRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}

- (void)_postRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}

- (void)_deleteRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}


- (void)_headRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}

- (void)_patchRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}


- (void)_putRequest:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler {
    [self requestAction:dto complete:completionHandler];
}

- (void)_downloadRequest:(DownloadRequestDTO *)dto complete:(void (^)(DownloadReponseDTO *, BOOL))completionHandler {
    NSURL *url = [NSURL URLWithString:dto.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSString *path = NSTemporaryDirectory();
    
    NSString *filePath = [path stringByAppendingPathComponent:[dto.url md5HexDigest]];
    NSURLSessionDownloadTask *task = [self.network downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            double progress = (double)downloadProgress.completedUnitCount / (double)downloadProgress.totalUnitCount;
            UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            if (dto.__event__.length > 0){
                [webVC runJsFunction:dto.__event__ arguments:@[@(progress)]];
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSString *destinationString = [filePath absoluteString];
        if ([destinationString hasPrefix:@"file://"]){
            destinationString = [destinationString substringFromIndex:7];
        }
    
        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)response;
        DownloadReponseDTO *ret = [[DownloadReponseDTO alloc] init];
        if(dto.isNeedBase64){
            NSData *data = [NSData dataWithContentsOfURL:filePath];
            NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            ret.base64DataStr = [NSString stringWithFormat:@"data:image/png;base64,%@", base64String];
        }
        ret.request = dto;
        ret.filePath = destinationString;
//        ret.destination = destinationString;
        ret.status = responseObj.statusCode;
        ret.headers = responseObj.allHeaderFields;
        completionHandler(ret , YES);
    }];
    [task resume];
}

- (void)_uploadRequest:(UploadRequestDTO *)dto complete:(void (^)(UploadReponseDTO *, BOOL))completionHandler {
    NSString *str = [NSString stringWithString:dto.url];
    NSMutableDictionary *headers     = [dto.headers mutableCopy];
    headers[@"Content-Type"] = @"multipart/form-data";
    NSDictionary *parameters  = dto.params;
    
//    NSData *data = nil;
//    if(dto.fileBaseStr.length > 0){
//        NSRange range = [dto.fileBaseStr rangeOfString:@"base64,"];
//        if(range.location != NSNotFound){
//            NSString *fileBase = [dto.fileBaseStr substringFromIndex:range.location + range.length];
//            data = [[NSData alloc] initWithBase64EncodedString:fileBase options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        }
//    }
//    if(data == nil){
//        data = [NSData dataWithContentsOfFile:dto.filepath];
//    }
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:str]];
//    request.HTTPMethod = @"POST";
//    NSURLSessionDataTask *task = [self.network uploadTaskWithRequest:request fromData:data progress:^(NSProgress *uploadProgress) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            double progress = (double)uploadProgress.completedUnitCount / (double)uploadProgress.totalUnitCount;
//            UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//            if (dto.__event__.length > 0){
//                [webVC runJsFunction:dto.__event__ arguments:@[[NSString stringWithFormat:@"%.2f", progress]]];
//            }
//        });
//    } completionHandler:^(NSURLResponse *respone, id _Nullable responseObject, NSError *error) {
//
//        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)respone;
//        UploadReponseDTO *ret = [[UploadReponseDTO alloc] init];
//        ret.request = dto;
//        ret.data = responseObject;
//        ret.status = responseObj.statusCode;
//        ret.headers = responseObj.allHeaderFields;
//        completionHandler(ret , YES);
//    }];
    XEUploadDataModel *fileModel = [[XEUploadDataModel alloc] init];
    fileModel.filePath = dto.filepath;
    fileModel.fileName = @"filedata";
    fileModel.fileBase64Str = dto.fileBaseStr;
    fileModel.mimeType = @"image/jpeg";
    NSURLSessionDataTask *task = [self.network upload:str
                                           parameters:parameters
                                              headers:headers
                                             dataList:@[fileModel]
                                             progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            double progress = (double)uploadProgress.completedUnitCount / (double)uploadProgress.totalUnitCount;
            UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
            if (dto.__event__.length > 0){
                [webVC runJsFunction:dto.__event__ arguments:@[[NSString stringWithFormat:@"%.2f", progress]]];
            }
        });
    }
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)task.response;
        UploadReponseDTO *ret = [[UploadReponseDTO alloc] init];
        ret.request = dto;
        ret.data = responseObject;
        ret.status = responseObj.statusCode;
        ret.headers = responseObj.allHeaderFields;
        completionHandler(ret , YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)task.response;
        UploadReponseDTO *ret = [UploadReponseDTO new];
        ret.request = dto;
        ret.status = responseObj.statusCode;
        ret.headers = responseObj.allHeaderFields;
        completionHandler(ret , YES);
    }];
    [task resume];
}

- (NSURLSessionDownloadTask* )downloadTaskWithRequest:(NSURLRequest *)request progress:(nullable void (^)(NSProgress *))downloadProgressBlock destination:(nullable NSURL *(^)(NSURL *, NSURLResponse *))destination completionHandler:(nullable void (^)(NSURLResponse *, NSURL * _Nullable, NSError * _Nullable))completionHandler {
    return  [self.network downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}

- (void)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData progress:(void (^)(NSProgress *))uploadProgressBlock completionHandler:(void (^)(NSURLResponse *, id _Nullable, NSError * _Nullable))completionHandler {
    [self.network uploadTaskWithRequest:request fromData:bodyData progress:uploadProgressBlock completionHandler:completionHandler];
}

- (void)DELETE:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers success:(nullable void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure {
    [self.network requestAction:URLString method:@"DELETE" parameters:parameters headers:headers success:success failure:failure];
}


- (void)GET:(NSString * _Nonnull)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers progress:(nullable void (^)(NSProgress * _Nullable))downloadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    [self.network requestAction:URLString method:@"GET" parameters:parameters headers:headers success:success failure:failure];
}


- (void)HEAD:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers success:(nullable void (^)(NSURLSessionDataTask *))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure {
    [self.network requestAction:URLString method:@"HEAD" parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id obj) {
        if(success){
            success(task);
        }
    } failure:failure];
}

- (void)PATCH:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers success:(nullable void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure {
    [self.network requestAction:URLString method:@"PATCH" parameters:parameters headers:headers success:success failure:failure];
}


- (void)POST:(NSString * _Nonnull)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers progress:(nullable void (^)(NSProgress * _Nullable))uploadProgress success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    [self.network requestAction:URLString method:@"POST" parameters:parameters headers:headers success:success failure:failure];
}


- (void)PUT:(NSString *)URLString parameters:(nullable id)parameters headers:(nullable NSDictionary<NSString *,NSString *> *)headers success:(nullable void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure {
    [self.network requestAction:URLString method:@"PUT" parameters:parameters headers:headers success:success failure:failure];
}


-(void)requestAction:(RequestDTO *)dto complete:(void (^)(ReponseDTO *, BOOL))completionHandler{
    
    NSString     *url         = dto.url;
    NSString     *method      = dto.method;
    NSDictionary *headers     = dto.headers;
    NSDictionary *parameters  = dto.params;
    
    [self.network requestAction:url
                         method:method
                     parameters:parameters
                        headers:headers
                        success:^(NSURLSessionDataTask *task, id resposeObject) {
        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)task.response;
        ReponseDTO *ret = [ReponseDTO new];
        ret.request = dto;
        ret.data = resposeObject;
        ret.status = responseObj.statusCode;
        ret.headers = responseObj.allHeaderFields;
        completionHandler(ret , YES);
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSHTTPURLResponse *responseObj = (NSHTTPURLResponse *)task.response;
        ReponseDTO *ret = [ReponseDTO new];
        ret.request = dto;
        ret.status = responseObj.statusCode;
        ret.headers = responseObj.allHeaderFields;
        completionHandler(ret , YES);
    }];
}

-(void)unzip:(NSString *)zipPath withToPath:(NSString *)toPath complete:(void (^)(ReponseDTO *, BOOL))completionHandler{
    
}

//
//-(void)requestAction:(NSString *)URLString
//              method:(NSString *)method
//          parameters:(nullable id)parameters
//             headers:(nullable NSDictionary<NSString *,NSString *> *)headers
//             success:(nullable void (^)(NSURLSessionDataTask *, id _Nullable))successBlock
//             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *))failBlock{
//
//    if ([method isEqualToString:@"PUT"]){
//        [[AFHTTPSessionManager manager] PUT:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
//    } else if ([method isEqualToString:@"DELETE"]){
//        [[AFHTTPSessionManager manager] DELETE:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
//    } else if ([method isEqualToString:@"PATCH"]){
//        [[AFHTTPSessionManager manager] PATCH:URLString parameters:parameters headers:headers success:successBlock failure:failBlock];
//    }else if ([method isEqualToString:@"HEAD"]){
//        [[AFHTTPSessionManager manager] HEAD:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task) {
//            successBlock(task, nil);
//        } failure:failBlock];
//    } else if ([method isEqualToString:@"GET"]){
//        [[AFHTTPSessionManager manager] GET:URLString parameters:parameters headers:headers progress:nil success:successBlock failure:failBlock];
//    } else {
//        //默认POST
//        [[AFHTTPSessionManager manager] POST:URLString parameters:parameters headers:headers progress:nil success:successBlock failure:failBlock];
//    }
//}

@end

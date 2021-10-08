
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "x_api_gm_general_appVersion_checkUpdate.h"


@implementation x_api_gm_general_appVersion_checkUpdate_Req
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"os"]) { return YES; }
   if ([propertyName isEqualToString:@"platform"]) { return YES; }
   if ([propertyName isEqualToString:@"versionCode"]) { return YES; }
   if ([propertyName isEqualToString:@"versionName"]) { return YES; }
      return NO;
    }
    
@end

  
@implementation x_api_gm_general_appVersion_checkUpdate_Res
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"digest"]) { return YES; }
   if ([propertyName isEqualToString:@"externalUrl"]) { return YES; }
   if ([propertyName isEqualToString:@"isUpdate"]) { return YES; }
   if ([propertyName isEqualToString:@"remark"]) { return YES; }
   if ([propertyName isEqualToString:@"resUrl"]) { return YES; }
   if ([propertyName isEqualToString:@"title"]) { return YES; }
   if ([propertyName isEqualToString:@"type"]) { return YES; }
      return NO;
    }
    
@end


@implementation x_api_gm_general_appVersion_checkUpdate



- (NSString*) getMethod{
    return @"POST";
}

- (NSString*) getContentType{
    return @"application/json";
}

- (NSData*) getBody:(x_api_gm_general_appVersion_checkUpdate_Req*) dtoReq{
    if([[self getContentType] isEqualToString:@"application/json"])
        return  dtoReq.toJSONData;
    else{
        NSAssert(nil, @"请覆盖此方法,怎么序列化参数到 body");
        return nil;
    }
}
- (NSString*) getPath{
  return @"/gm/general/appVersion/checkUpdate";
}

- (NSString*) getFinalUrl{
    // 逻辑如下：
    // 1. 优先使用 localUrlPrefix， 也就是通过代码设置的
    // 2. 其次使用全局， 也是由代码设置
    // 3. 最后使用自动生成的
    // 4. 实在不满足你，直接覆盖getUrl 函数即可
    if(self.localUrlPrefix) {
        return [NSString stringWithFormat:@"%@%@",self.localUrlPrefix,[self getPath]];
    }
    if([KOBaseApi ko_getGlobalUrlPrefix]) {
        return [NSString stringWithFormat:@"%@%@",[KOBaseApi ko_getGlobalUrlPrefix],[self getPath]];
    }
    // 配置文件里没有 apiUrlPrefix, 将不会自动生成
    return @"";
}


- (void) request:(x_api_gm_general_appVersion_checkUpdate_Req* _Nullable) dtoReq response:(x_api_gm_general_appVersion_checkUpdateApiResponse _Nullable) response{
    self.network = [NSMutableURLRequest new];
    self.network.URL =[NSURL URLWithString:[self getFinalUrl]];
    self.network.HTTPMethod = [self getMethod];
    self.network.HTTPBody = [self getBody:dtoReq];
    [self activePipelineByName:[self getPipelineName]];
    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        id resPost = [[x_api_gm_general_appVersion_checkUpdate_Res alloc] initWithDictionary:data error:&err];
        response(resPost,res,[self errorWrapper:error underlyingError:err]);
    }];
}

- (void) request:(x_api_gm_general_appVersion_checkUpdateApiResponse _Nullable) response{
    [self request:self.dtoReq response:response];
}

- (FBLPromise<x_api_gm_general_appVersion_checkUpdate_Res *>* _Nullable) promise:(x_api_gm_general_appVersion_checkUpdate_Req* _Nullable) dtoReq{
    FBLPromise<x_api_gm_general_appVersion_checkUpdate_Res *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
      [self request:dtoReq response:^(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                fulfill(data);
            }else{
                reject(error);
            }
        }];
    }];
    return promise;
}

- (FBLPromise<x_api_gm_general_appVersion_checkUpdate_Res *>* _Nullable) promise{
    return [self promise:self.dtoReq];
}

@end



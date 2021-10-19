
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "x_api_undefined.h"
#import "NSURL+QueryDictionary.h"



@implementation x_api_undefined



- (NSString*) getMethod{
    return @"undefined";
}

- (NSString*) getContentType{
  // 如果觉得生成实现不对，请继承 getContentType 类，实现此方法即可。
  return @"application/json";
}

- (NSData*) getBody:(undefined*) dtoReq{
  // 如果觉得生成实现不对，请继承 x_api_gm_general_login 类，实现此方法即可。
  if([[self getMethod] isEqualToString:@"GET"]){
      return [NSData new];
  }
  return [super getBody:dtoReq];
}

- (NSString*) getPath:(undefined*) dtoReq{
  // 如果觉得生成实现不对，请继承 x_api_gm_general_login 类，实现此方法即可。
  NSString* path = @"undefined";
  if([[self getMethod] isEqualToString:@"GET"]){
     NSString* queryStr = dtoReq.toDictionary.uq_URLQueryString;
      if(nil  == queryStr || queryStr.length == 0){
          return [NSString stringWithFormat:@"%@",path];
      }else{
          return [NSString stringWithFormat:@"%@?%@",path,queryStr];
      }
  }else{
      return path;
  }
}

- (NSString*) getFinalUrl:(undefined*) dtoReq{
  // 如果觉得生成实现不对，请继承 x_api_gm_general_login 类，实现此方法即可。
  
  // 逻辑如下：
  // 1. 优先使用 localUrlPrefix， 也就是通过代码设置的
  // 2. 其次使用全局， 也是由代码设置
  // 3. 最后使用自动生成的
  // 4. 实在不满足你，直接覆盖getUrl 函数即可
  
  if(self.localUrlPrefix) {
      return [NSString stringWithFormat:@"%@%@",self.localUrlPrefix,[self getPath:dtoReq]];
  }
  if([KOBaseApi ko_getGlobalUrlPrefix]) {
      return [NSString stringWithFormat:@"%@%@",[KOBaseApi ko_getGlobalUrlPrefix],[self getPath:dtoReq]];
  }
  // 配置文件里没有 apiUrlPrefix, 将不会自动生成
      return @"";
}


- (void) request:(undefined* _Nullable) dtoReq response:(x_api_undefinedApiResponse _Nullable) response{
    NSURL* url =[NSURL URLWithString:[self getFinalUrl:dtoReq]];
    if(!url){
        NSLog(@"url 没转换出来，为空，查看参数有没问题");
        return;
    }
    self.network = [NSMutableURLRequest new];
    self.network.URL = url;
    self.network.HTTPMethod = [self getMethod];
    self.network.HTTPBody = [self getBody:dtoReq];
    [self.network setValue:[self getContentType] forHTTPHeaderField:@"Content-Type"];
    [self activePipelineByName:[self getPipelineName]];
    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        id resPost = [[undefined alloc] initWithDictionary:data error:&err];
        response(resPost,res,[self errorWrapper:error underlyingError:err]);
    }];
}

- (void) request:(x_api_undefinedApiResponse _Nullable) response{
    [self request:self.dtoReq response:response];
}

- (FBLPromise<undefined *>* _Nullable) promise:(undefined* _Nullable) dtoReq{
    FBLPromise<undefined *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
      [self request:dtoReq response:^(undefined * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                fulfill(data);
            }else{
                reject(error);
            }
        }];
    }];
    return promise;
}

- (FBLPromise<undefined *>* _Nullable) promise{
    return [self promise:self.dtoReq];
}

@end


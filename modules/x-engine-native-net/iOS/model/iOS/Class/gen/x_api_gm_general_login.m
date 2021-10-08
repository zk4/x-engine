
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "x_api_gm_general_login.h"
#import "NSURL+QueryDictionary.h"

@implementation x_api_gm_general_login_Req
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"ldapId"]) { return YES; }
   if ([propertyName isEqualToString:@"password"]) { return YES; }
   if ([propertyName isEqualToString:@"username"]) { return YES; }
      return NO;
    }
    
@end

  
@implementation x_api_gm_general_login_Res
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"sessionToken"]) { return YES; }
   if ([propertyName isEqualToString:@"userToken"]) { return YES; }
   if ([propertyName isEqualToString:@"bizUser"]) { return YES; }
      return NO;
    }
    
    - (x_api_gm_general_login_Res_bizUser* )bizUser{ 
      if(!_bizUser){ 
        _bizUser = [x_api_gm_general_login_Res_bizUser new];}
        return _bizUser;
      }
    
@end

  
@implementation x_api_gm_general_login_Res_bizUser
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
      if ([propertyName isEqualToString:@"avatar"]) { return YES; }
   if ([propertyName isEqualToString:@"createdTime"]) { return YES; }
   if ([propertyName isEqualToString:@"email"]) { return YES; }
   if ([propertyName isEqualToString:@"genderType"]) { return YES; }
   if ([propertyName isEqualToString:@"id"]) { return YES; }
   if ([propertyName isEqualToString:@"nickname"]) { return YES; }
   if ([propertyName isEqualToString:@"phoneNum"]) { return YES; }
   if ([propertyName isEqualToString:@"realname"]) { return YES; }
   if ([propertyName isEqualToString:@"status"]) { return YES; }
   if ([propertyName isEqualToString:@"updatedTime"]) { return YES; }
   if ([propertyName isEqualToString:@"userKey"]) { return YES; }
      return NO;
    }
    
@end


@implementation x_api_gm_general_login



- (NSString*) getMethod{
    return @"POST";
}

- (NSString*) getContentType{
    return @"application/x-www-form-urlencoded";
}

- (NSData*) getBody:(x_api_gm_general_login_Req*) dtoReq{
    if([[self getContentType] isEqualToString:@"application/json"])
        return  dtoReq.toJSONData;
    else if([[self getContentType] isEqualToString:@"application/x-www-form-urlencoded"]){
       NSDictionary* d =  dtoReq.toDictionary;
       return [d.uq_URLQueryString dataUsingEncoding:NSUTF8StringEncoding];
    }
    else{
        NSAssert(nil, @"请覆盖此方法,怎么序列化参数到 body");
        return nil;
    }
}
- (NSString*) getPath{
  return @"/login/ldap/1";
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
    return [NSString stringWithFormat:@"%@%@",@"http://10.115.91.95:9530/bff-b",[self getPath]];
}


- (void) request:(x_api_gm_general_login_Req* _Nullable) dtoReq response:(x_api_gm_general_loginApiResponse _Nullable) response{
    self.network = [NSMutableURLRequest new];
    self.network.URL =[NSURL URLWithString:[self getFinalUrl]];
    self.network.allHTTPHeaderFields = [self getHeaders];
    self.network.HTTPMethod = [self getMethod];
    self.network.HTTPBody = [self getBody:dtoReq];
    [self activePipelineByName:[self getPipelineName]];
    [self.network send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSError* err;
        id resPost = [[x_api_gm_general_login_Res alloc] initWithDictionary:data error:&err];
        response(resPost,res,[self errorWrapper:error underlyingError:err]);
    }];
}

- (void) request:(x_api_gm_general_loginApiResponse _Nullable) response{
    [self request:self.dtoReq response:response];
}

- (FBLPromise<x_api_gm_general_login_Res *>* _Nullable) promise:(x_api_gm_general_login_Req* _Nullable) dtoReq{
    FBLPromise<x_api_gm_general_login_Res *>* promise = [FBLPromise async:^(FBLPromiseFulfillBlock fulfill, FBLPromiseRejectBlock reject) {
      [self request:dtoReq response:^(x_api_gm_general_login_Res * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            if(!error){
                fulfill(data);
            }else{
                reject(error);
            }
        }];
    }];
    return promise;
}

- (FBLPromise<x_api_gm_general_login_Res *>* _Nullable) promise{
    return [self promise:self.dtoReq];
}

@end



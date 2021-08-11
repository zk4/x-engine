//
//  JSI_webcache.m
//  webcache
//


#import "JSI_webcache.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_webcache() <NSURLSessionDelegate>
@property (nonatomic, strong) NSMutableDictionary* cache;
@end

@implementation JSI_webcache
JSI_MODULE(JSI_webcache)

- (void)afterAllJSIModuleInited {
    _cache = [NSMutableDictionary new];
}

- (NSMutableDictionary *)makeSafeHeaders:(NSDictionary *)headers {
    NSMutableDictionary* safeHeaders = [NSMutableDictionary new];
    // 遍历 headers,将数字转为字符
    for (NSString *headerField in headers.keyEnumerator) {
        if([headers[headerField] isKindOfClass:NSNumber.class]){
            NSString* newVal = [NSString stringWithFormat:@"%@",headers[headerField]];
            [safeHeaders setValue:newVal forKey:headerField];
            
        }else {
            [safeHeaders setValue:headers[headerField] forKey:headerField];
        }
    }
    return safeHeaders;
}


- (void)_xhrRequest:(NSDictionary *)dict complete:(void (^)(NSString*,BOOL))completionHandler {
    NSLog(@"%@", dict);
    
    // 可以参考一下这个 https://github1s.com/eclipsesource/tabris-js/blob/HEAD/src/tabris/XMLHttpRequest.js#L8
    NSDictionary* headers = dict[@"header"];
    NSString *url = dict[@"url"];
    NSString *method = dict[@"method"];
    
    NSString *cacheKey = nil;
    if([method isEqualToString:@"GET"]){
        if(dict && ![self isNull:dict key:@"data"] && dict[@"data"])
            cacheKey = [NSString stringWithFormat:@"%@%@",url ,dict[@"data"]];
        cacheKey = url;
    } else {
        //     cacheKey = [NSString stringWithFormat:@"%@%@",method ,url];
    }
    
    // 仅缓存 GET, 如果有更新,则会会二次返回,
    if([_cache objectForKey:cacheKey]){
        //&&
        NSLog(@"cache+jsi =>%@:%@",method, cacheKey);
        completionHandler(_cache[cacheKey],TRUE);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = method;
    request.allHTTPHeaderFields = [self makeSafeHeaders:headers];
    
    // 如果 content-type = multipart/form-data
    NSString *type = [NSString stringWithFormat:@"%@", dict[@"headers"][@"Content-Type"]];
    if([type isEqualToString:@"multipart/form-data"]) {
        NSArray *tempArr = dict[@"data"];
//        NSMutableString *bodyString = [NSMutableString string];
        NSMutableData *mutableData = [NSMutableData data];
        for (NSString *str in tempArr) {
//            NSString *splicingStr = [self base64Dencode:str];
//            NSLog(@"%@", splicingStr);
            NSData *data = [self base64Decode:str];
            [mutableData appendData:data];
//            if (splicingStr.length != 0) {
//                [bodyString appendString:splicingStr];
//            }
        }
//        NSLog(@"bodyString==>%@", bodyString);
        request.HTTPBody = [mutableData copy];
    } else {
        // post 有可能没有 body
        if(dict && ![self isNull:dict key:@"data"] && dict[@"data"]){
            if([dict[@"data"] isKindOfClass:NSString.class]){
                request.HTTPBody = [dict[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
            }
        }
    }
    NSLog(@"methods==>%@\n URL==>%@\n Body==>%@",request.HTTPMethod, request.URL, request.HTTPBody);
    
    __weak typeof(self) weakSelf = self;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
        NSLog(@"%@", error);
        if (!error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)r;
            NSString *statusCode =[NSString stringWithFormat:@"%zd",[response statusCode]] ;
            NSString *responseText = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"statusCode"] = statusCode;
            dict[@"responseText"] = responseText;
            dict[@"responseHeaders"] = headers;
            NSLog(@"dict======>%@", dict);
            if(cacheKey) weakSelf.cache[cacheKey] = dict;
            completionHandler([self dictionaryToJson:dict],TRUE);
        } else {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"error"] = [NSString stringWithFormat:@"%@", error];
            completionHandler([self dictionaryToJson:dict],TRUE);
        }
    }];
    [sessionTask resume];
}

//- (NSURLRequest *)POSTImage:(NSString *)URLString data:(NSData *)imageData name:(NSString*)name finish:(RequestFinish)finish{
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    [request setHTTPMethod:@"POST"];
//    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//    [request setTimeoutInterval:20];
//    NSString* headerString = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@",UploadImageBoundary];
//    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
//    NSMutableData* requestMutableData = [NSMutableData data];
//    NSMutableString* myString = [NSMutableString stringWithFormat:@"--%@\r\n",UploadImageBoundary];
//    [myString appendString:@"Content-Disposition: form-data; name=\"appid\"\r\n\r\n"];/*这里要打两个回车*/
//    [myString appendString:@"100118"];
//    [myString appendString:[NSString stringWithFormat:@"\r\n--%@\r\n",UploadImageBoundary]];
//    [myString appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",name]];
//    [myString appendString:@"Content-Type: image/jpeg\r\n\r\n"];
//    /*转化为二进制数据*/
//    [requestMutableData appendData:[myString dataUsingEncoding:NSUTF8StringEncoding]];
    /*文件数据部分，也是二进制*/
//    [requestMutableData appendData:imageData];
    /*已--boundary结尾表明结束*/
//    [requestMutableData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",UploadImageBoundary] dataUsingEncoding:NSUTF8StringEncoding] ];
    
//    request.HTTPBody = requestMutableData;
    
    
    /*开始上传*/
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfig.timeoutIntervalForRequest = 20;
//    NSURLSession* session  = [NSURLSession sessionWithConfiguration:sessionConfig
//                                                        delegate:self
//                                                   delegateQueue:nil];
//
//    NSURLSessionDataTask * uploadtask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        if (finish) {
//            finish(nil,dictionary,error);
//        }
//    }];
//    [uploadtask resume];
//    return request;
//}

//字典转json格式字符串:
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (BOOL)isNull:(NSDictionary *)dict key:(NSString*)key{
    // judge nil
    if(![dict objectForKey:key]){
        return NO;
    }
    id obj = [dict objectForKey:key];// judge NSNull
    BOOL isNull = [obj isEqual:[NSNull null]];
    return isNull;
}


- (NSString *)base64Encode:(NSData *)sData{
    if (!sData) {
        return nil;
    }
//    NSData *sData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [sData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}
 
- (NSData *)base64Decode:(NSString *)string{
    if (!string) {
        return nil;
    }
    NSData *sData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSString *dataString = [[NSString alloc]initWithData:sData encoding:NSUTF8StringEncoding];
    return sData;
}
@end

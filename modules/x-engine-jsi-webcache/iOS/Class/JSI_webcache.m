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
    
    // post 有可能没有 body
    if(dict && ![self isNull:dict key:@"data"] && dict[@"data"]){
        if([dict[@"data"] isKindOfClass:NSString.class]){
            request.HTTPBody = [dict[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    NSLog(@"methods==>%@\n URL==>%@\n Body==>%@",request.HTTPMethod, request.URL, request.HTTPBody);
    
    __weak typeof(self) weakSelf = self;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)r;
            NSString *statusCode =[NSString stringWithFormat:@"%zd",[response statusCode]] ;
            NSString *responseText = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"statusCode"] = statusCode;
            dict[@"responseText"] = responseText;
            dict[@"responseHeaders"] = headers;
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
@end

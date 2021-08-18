//
//  JSI_webcache.m
//  webcache
//


#import "JSI_webcache.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "XTool.h"

@interface JSI_webcache()
@property (nonatomic, strong) NSMutableDictionary* cache;

@end

@implementation JSI_webcache
JSI_MODULE(JSI_webcache)

- (void)afterAllJSIModuleInited {
    _cache=[NSMutableDictionary new];
}

-(BOOL)isNull:(NSDictionary *)dict key:(NSString*)key{
    // judge nil
    if(![dict objectForKey:key]){
        return NO;
    }
    
    id obj = [dict objectForKey:key];// judge NSNull
    
    BOOL isNull = [obj isEqual:[NSNull null]];
    return isNull;
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




- (void)_xhrRequest:(NSDictionary *)dict complete:(void (^)(NSDictionary*,BOOL))completionHandler {
// 可以参考一下这个 https://github1s.com/eclipsesource/tabris-js/blob/HEAD/src/tabris/XMLHttpRequest.js#L8
    NSDictionary* headers = dict[@"headers"];
    NSString* url = dict[@"url"];
    NSString* method = dict[@"method"];

    NSString* cacheKey=nil;
    if([method isEqualToString:@"GET"]){
        if(dict && ![self isNull:dict key:@"data"] && dict[@"data"])
            cacheKey = [NSString stringWithFormat:@"%@%@%@",method, url ,dict[@"data"]];
        cacheKey =url;
    }else{
   //     cacheKey = [NSString stringWithFormat:@"%@%@",method ,url];
    }

    
    // 仅缓存 GET, 如果有更新,则会会二次返回,
    if([_cache objectForKey:cacheKey]){
        NSLog(@"cache+jsi =>%@:%@",method, cacheKey);
        completionHandler(_cache[cacheKey],TRUE);
        return;
    }

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    request.HTTPMethod = method;
    request.allHTTPHeaderFields= [self makeSafeHeaders:headers];
    
    // post 有可能没有 body
    if(dict && ![self isNull:dict key:@"data"] && dict[@"data"]){
        if([dict[@"data"] isKindOfClass:NSString.class]){
            request.HTTPBody = [dict[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        }else  if([dict[@"data"] isKindOfClass:NSArray.class]){
            NSArray *tempArr = dict[@"data"];

            NSMutableData *mutableData = [NSMutableData data];
            for (NSString *str in tempArr) {
                NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
                [mutableData appendData:data];
            }
            request.HTTPBody = [mutableData copy];
        }
    }
    
    NSLog(@"jsi:%@ => %@:%@",request.HTTPMethod, request.URL, request.HTTPMethod);
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:nil];

    __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
            if (!error) {
                NSString* body =     [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",body);
                NSHTTPURLResponse *response =nil;
                response = (NSHTTPURLResponse *)r;
                NSString* statusCode =[NSString stringWithFormat:@"%zd",[response statusCode]] ;
                NSString* responseText = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};
    
    
                NSDictionary* ret =@{
                    @"statusCode": statusCode,
                    @"responseText":responseText,
                    @"responseHeaders":headers
                };
                if(cacheKey)
                    weakSelf.cache[cacheKey] = ret;
                completionHandler(ret,TRUE);
    
            } else {
                NSDictionary* ret =@{
    
                    @"error":[NSString stringWithFormat:@"%@", error]
                };
                completionHandler(ret,TRUE);
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

  
@end

//
//  JSI_webcache.m
//  webcache
//


#import "JSI_webcache.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "XTool.h"

@interface JSI_webcache()
@property (atomic, strong) NSMutableDictionary* cache;

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
    }else if([method isEqualToString:@"POST"]){
        if(   [url containsString:@"goods/c/app/product/productDetail"]
           || [url containsString:@"/router-service/"]
           || [url containsString:@"/serviceProduct/detail"])
            cacheKey = [NSString stringWithFormat:@"%@%@%@",method ,url,dict[@"data"]];
    }

    
    // 仅缓存 GET, 如果有更新,则会会二次返回,
    if(cacheKey && [_cache objectForKey:cacheKey]){
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
    
    NSURLSessionConfiguration* config
     = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPMaximumConnectionsPerHost=10;

    
    //WARNING: 想换成其他网络请求库时请请注意json 序列化的问题。不要转多遍。jsonStr 里的 '浮点类型'，在转为原生类型时，会丢失精度。再转为 jsonStr 时就不是你要的值了。如 str: '{a:.3}' -> objc: @{@"a":.299999999999}  ->  str '{"a":.29999999999}'
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

    __weak typeof(self) weakSelf = self;
        NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
            if (!error) {
                NSHTTPURLResponse *response =nil;
                response = (NSHTTPURLResponse *)r;
                NSString* statusCode =[NSString stringWithFormat:@"%zd",[response statusCode]] ;
                NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};
                
                // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
                NSString* type =  headers[@"Content-Type"];
                BOOL isBinary =type? !([type containsString:@"text/"] || [type containsString:@"/json"]): NO;

                NSDictionary* ret =@{
                    @"statusCode": statusCode,
                    @"isBinary":[NSNumber numberWithBool:isBinary],
                    @"data":isBinary?[data base64EncodedStringWithOptions:0]:[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding],
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

 
@end

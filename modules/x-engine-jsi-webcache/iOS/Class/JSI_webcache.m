//
//  JSI_webcache.m
//  webcache
//


#import "JSI_webcache.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_webcache()
@end

@implementation JSI_webcache
JSI_MODULE(JSI_webcache)

- (void)afterAllJSIModuleInited {
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
// 直接使用,不经过 gen
- (void) xhrRequest:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    
    NSDictionary* headers = dict[@"header"];
    NSString* url = dict[@"url"];
    NSString* xhrId = dict[@"xhrId"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = dict[@"method"];
    
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
    request.allHTTPHeaderFields= safeHeaders;
    // post 有可能没有 body
    if(![self isNull:dict key:@"data"])
        request.HTTPBody = [dict[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"jsi:%@ => %@:%@",request.HTTPMethod, request.URL, request.HTTPMethod);

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)r;
            NSString* statusCode =[NSString stringWithFormat:@"%d",[response statusCode]] ;
            NSString* responseText = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};


            NSDictionary* ret =@{
                @"xhrId":xhrId,
                @"statusCode": statusCode,
                @"responseText":responseText,
                @"responseHeaders":headers
            };
            completionHandler(ret,TRUE);
            
        } else {
            NSDictionary* ret =@{
                @"xhrId":xhrId,
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

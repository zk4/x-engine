//
//  JSI_webcache.m
//  webcache
//


#import "JSI_webcache.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "XTool.h"
#import "NSMutableURLRequest+Filter.h"

#import "GlobalReqResMergeRequestFilter.h"
#import "GlobalReqConfigFilter.h"
#import "GlobalResStatusCodeNot2xxFilter.h"
#import "NSMutableURLRequest+Filter.h"
#import "GlobalResNoResponseFilter.h"
#import "GlobalReqInnerNetworkDetectorFilter.h"

#import "KOHttp.h"

@interface JSI_webcache()
@property (nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation JSI_webcache
JSI_MODULE(JSI_webcache)

- (void)afterAllJSIModuleInited {
    [KOHttp ko_configPipelineByName:@"WEB_CACHE" pipeline:({
        NSMutableArray* pipeline  =[NSMutableArray new];
        [pipeline addObject:[GlobalReqInnerNetworkDetectorFilter sharedInstance]];
        [pipeline addObject:[GlobalReqConfigFilter sharedInstance]];
//        [pipeline addObject:[GlobalResStatusCodeNot2xxFilter sharedInstance]];
        [pipeline addObject:[GlobalResNoResponseFilter sharedInstance]];
//        [pipeline addObject:[GlobalReqResMergeRequestFilter sharedInstance]];
        pipeline;
    })];
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
    //WARNING: 想换成其他网络请求库时请请注意json 序列化的问题。不要转多遍。jsonStr 里的 '浮点类型'，在转为原生类型时，会丢失精度。再转为 jsonStr 时就不是你要的值了。如 str: '{a:.3}' -> objc: @{@"a":.299999999999}  ->  str '{"a":.29999999999}'

    [request activePipelineByName:@"WEB_CACHE"];
    [request send:^(id  _Nullable data, NSURLResponse * _Nullable r, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *response =nil;
            response = (NSHTTPURLResponse *)r;
            NSString* statusCode =[NSString stringWithFormat:@"%zd",[response statusCode]] ;
            NSDictionary* headers = response.allHeaderFields?response.allHeaderFields:@{};
            
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
            NSString* type =  headers[@"Content-Type"];
            BOOL isBinary = NO;
            if(type){
             isBinary =type? !([type containsString:@"text/"] || [type containsString:@"/json"]): NO;
            }

            NSString* sdata =isBinary?[data base64EncodedStringWithOptions:0]:[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            if(!sdata) sdata = @"";
            NSDictionary* ret =@{
                @"statusCode": statusCode,
                @"isBinary":[NSNumber numberWithBool:isBinary],
                @"data":sdata,
                @"responseHeaders":headers
            };
            completionHandler(ret,TRUE);
        } else {
            NSDictionary* ret =@{
                @"error":[NSString stringWithFormat:@"%@", error]
            };
            completionHandler(ret,TRUE);
        }
    }];
 
}

 
@end

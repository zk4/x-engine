//
//  Native_gmupload.m
//  gmupload
//


#import "Native_gmupload.h"
#import "XENativeContext.h"

@interface Native_gmupload() <NSURLSessionDelegate>
{ }
@end

@implementation Native_gmupload
NATIVE_MODULE(Native_gmupload)

 - (NSString*) moduleId{
    return @"com.zkty.native.gmupload";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
}

-(void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName success:(void (^)(NSDictionary *))success failure:(void (^)(NSDictionary *))failure {
    NSString *boundary = [NSString stringWithFormat:@"iOSFormBoundary%@", [self randomString:16]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableDictionary *headerDict = [self makeSafeHeaders:header];
    request.allHTTPHeaderFields = headerDict;
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    
    // content-type
    NSString* headerString = [NSString stringWithFormat:@"multipart/form-data; boundary=----%@",boundary];
    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
    // body
    NSMutableData* requestMutableData = [NSMutableData data];
    NSMutableString *bodyString = [NSMutableString string];
    
    // 开始
    [bodyString appendString:[NSString stringWithFormat:@"\r\n------%@\r\n",boundary]];
    [bodyString appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.png\"\r\n",imageName]];
    [bodyString appendString:@"Content-Type: image/png\r\n\r\n"];
    
    // 转化为二进制数据
    [requestMutableData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    // 二进制图
    [requestMutableData appendData:imageData];
    // 结尾
    [requestMutableData appendData:[[NSString stringWithFormat:@"\r\n------%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = requestMutableData;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 2;
    NSURLSession* session  = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDataTask *uploadtask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (success) {
                success(dict);
            }
        } else {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"code"] = @(-1);
            dict[@"msg"] = error;
            if (failure) {
                failure(dict);
            }
        }
    }];
    [uploadtask resume];
}

/*************************************utils************************************************/
- (NSMutableDictionary *)makeSafeHeaders:(NSDictionary *)headers {
    NSMutableDictionary* safeHeaders = [NSMutableDictionary new];
    // 遍历 headers,将数字转为字符
    for (NSString *headerField in headers.keyEnumerator) {
        
        if([headers[headerField] isKindOfClass:NSNumber.class]){
            NSString* newVal = [NSString stringWithFormat:@"%@",headers[headerField]];
            [safeHeaders setValue:newVal forKey:headerField];
            
        } else {
            [safeHeaders setValue:headers[headerField] forKey:headerField];
        }
    }
    return safeHeaders;
}

- (NSString *)randomString:(NSInteger)number {
    NSString *ramdom;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i ; i ++) {
        int a = (arc4random() % 122);
        if (a > 96) {
            char c = (char)a;
            [array addObject:[NSString stringWithFormat:@"%c",c]];
            if (array.count == number) {
                break;
            }
        } else continue;
    }
    ramdom = [array componentsJoinedByString:@""];
    return ramdom;
}

@end
 

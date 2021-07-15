//
//  Native_direct.m
//  direct
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "iDirect.h"
#import "NSString+Router+URLQuery.h"

@interface Native_direct()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iDirect>> * directors;
@end

@implementation Native_direct
NATIVE_MODULE(Native_direct)

 - (NSString*) moduleId{
    return @"com.zkty.native.direct";
}

- (int) order{
    return 0;
}

- (instancetype)init
{
    self = [super init];
    self.directors=[NSMutableDictionary new];
    return self;
}

- (void)afterAllNativeModuleInited{
   NSArray* modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        [self.directors setObject:direct forKey:[direct scheme]];
    }
}

- (void)back: (NSString*) scheme host:(NSString*) host fragment:(NSString*) fragment{
    id<iDirect> direct = [self.directors objectForKey:scheme];
    [direct back:host fragment:fragment];
}


- (nonnull UIViewController *)getContainer:(nonnull NSString *)scheme host:(nullable NSString *)host pathname:(nonnull NSString *)pathname fragment:(nullable NSString *)fragment query:(nullable NSDictionary<NSString *,id> *)query params:(nullable NSDictionary<NSString *,id> *)params {
    id<iDirect> direct = [self.directors objectForKey:scheme];
    UIViewController* container =[direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];

    return container;
    
}

- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,NSString*>*) params {
    id<iDirect> direct = [self.directors objectForKey:scheme];
    UIViewController* container =[direct getContainer:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];
    if(container){
        [direct push:container params:params];
    }
}

- (void)addToTab: (UIViewController*) parent
        scheme:(NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(nullable NSString*) fragment
        query:(nullable NSDictionary<NSString*,id>*) query
          params:(nullable NSDictionary<NSString*,id>*) params{
    id<iDirect> direct = [self.directors objectForKey:scheme];
    UIViewController* vc =  [direct getContainer:[direct protocol] host:host pathname:@"" fragment:fragment query:query params:params];
    [parent addChildViewController:vc];
    [parent.view addSubview:vc.view];
    vc.view.frame = parent.view.frame;
}

static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
static NSString *const kSlash               = @"/";

- (NSString*)SPAUrl2StandardUrl:(NSString*)raw {
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< raw.length;i++){
        char cc= [raw characterAtIndex:i];

        if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
        // 仅当找到 hashtag 后才再找?, 不然不是 SPA url
        if(hashtagMark != -1 && cc == '?' && questionMark == -1){
            questionMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* sub1= [raw substringToIndex:hashtagMark];
        NSString* sub2= [raw substringWithRange:NSMakeRange(hashtagMark, questionMark-hashtagMark)];
        NSString* sub3=[ [raw substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
}


- (void)push:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params{
    // convert SPA url hash router style to standard url style
    NSURL* url = [NSURL URLWithString:[self SPAUrl2StandardUrl:uri]];
    NSNumber* port = url.port;
    if(!port){
        if([url.scheme isEqualToString:@"https"])
            port = @443;
        else if([url.scheme isEqualToString:@"http"])
            port = @80;
        
    }
    NSString* host = [NSString stringWithFormat:@"%@%@%@",url.host,port?@":":@"",port?port:@""];

    [self push:url.scheme host:host pathname:url.path fragment:url.fragment query:url.parameterString.uq_queryDictionary params:params];
}

- (void)addToTab:(nonnull UIViewController *)parent uri:(nonnull NSString *)uri params:(nullable NSDictionary<NSString *,id> *)params {
    // convert SPA url hash router style to standard url style
    NSURL* url = [NSURL URLWithString:[self SPAUrl2StandardUrl:uri]];
    NSNumber* port = url.port;
    if(!port){
        if([url.scheme isEqualToString:@"https"])
            port = @443;
        else if([url.scheme isEqualToString:@"http"])
            port = @80;
        
    }
    NSString* host = [NSString stringWithFormat:@"%@%@%@",url.host,port?@":":@"",port?port:@""];
    

    [self addToTab:parent scheme:url.scheme host:host pathname:url.path fragment:url.fragment query:url.parameterString.uq_queryDictionary params:params];

}



@end
 

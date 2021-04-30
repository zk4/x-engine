//
//  Native_direct.m
//  direct
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_direct.h"
#import "NativeContext.h"
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
   NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iDirect)];
    for(id<iDirect> direct in modules){
        [self.directors setObject:direct forKey:[direct scheme]];
    }
}

- (void)back: (NSString*) scheme host:(NSString*) host fragment:(NSString*) fragment{
    id<iDirect> direct = [self.directors objectForKey:scheme];
    [direct back:host fragment:fragment];
}

- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        pathname:(NSString*) pathname
        fragment:(NSString*) fragment
        query:(nullable NSDictionary<NSString*,NSString*>*) query
        params:(NSDictionary<NSString*,NSString*>*) params {
    id<iDirect> direct = [self.directors objectForKey:scheme];
    [direct push:[direct protocol] host:host pathname:pathname fragment:fragment query:query params:params];
}



static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
static NSString *const kSlash               = @"/";

+ (NSString*)SPAUrl2StandardUrl:(NSString*)raw {
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
    NSURL* url = [NSURL URLWithString:[Native_direct SPAUrl2StandardUrl:uri]];

    NSString* host = [NSString stringWithFormat:@"%@:%@",url.host,url.port];
    [self push:url.scheme host:host pathname:url.path fragment:url.fragment query:url.parameterString.uq_queryDictionary params:params];
}


@end
 

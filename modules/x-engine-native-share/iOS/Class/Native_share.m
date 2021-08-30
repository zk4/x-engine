//
//  Native_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share.h"
#import "XENativeContext.h"
#import "iShare.h"
@interface Native_share()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iShare>> *shares;

@end

@implementation Native_share
NATIVE_MODULE(Native_share)

 - (NSString*) moduleId{
    return @"com.zkty.native.share";
}

- (int) order{
    return 0;
}

- (instancetype)init
{
    self = [super init];
    self.shares = [NSMutableDictionary new];
    return self;
}

- (void)afterAllNativeModuleInited{
    NSArray *modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iShare)];
    for(id<iShare> share in modules){
        for (NSString* channel in [share getChannels])
        [self.shares setObject:share forKey:channel];
    }
}

///分享图片
- (void)shareWithType:(nonnull NSString *)type channel:(nonnull NSString *)channel posterInfo:(nonnull NSDictionary *)info complete:(nonnull void (^)( BOOL))completionHandler {
  
    id<iShare> share = [self.shares objectForKey:type];
    if(share)
    {
        [share shareWithType:type channel:channel posterInfo:info complete:^(BOOL complete) {
           completionHandler(complete);
        }];
    }else{
        //TDOO
    }
}
@end



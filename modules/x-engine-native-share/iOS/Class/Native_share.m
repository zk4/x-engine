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
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSMutableArray<id<iShare>>*> *shares;

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
         for(NSString* type in [share getTypes] )
         {
             NSMutableArray* array = [self.shares objectForKey:type];
             if(!array){
                 array= [NSMutableArray new];
                 [self.shares setObject:array forKey:type];
             }
             [array addObject:share];
         }
     }
}

///分享图片
- (void)shareWithType:(nonnull NSString *)type channel:(nonnull NSString *)channel posterInfo:(nonnull NSDictionary *)info complete:(nonnull void (^)(NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, BOOL))completionHandler {
    id<iShare> ishare = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iShare)];
    [ishare shareWithType:type channel:channel posterInfo:info complete:^(NSString * _Nonnull channel, NSString * _Nonnull shareType, NSString * _Nonnull imageData, BOOL complete) {
        completionHandler(channel,shareType,imageData,YES);
    }];

}

@end



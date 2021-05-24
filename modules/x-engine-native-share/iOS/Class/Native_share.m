//
//  Native_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share.h"
#import "NativeContext.h"
#import "iShare.h"
@class ChannelListModel;
@class ShareGoodsModel;
@class ShareStatusModel;

@implementation ChannelListModel

@end

@implementation ShareGoodsModel

@end

@implementation ShareStatusModel

@end

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
    NSArray *modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iShare)];
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

- (void)shareTypeWithType:(nonnull NSString *)type shareData:(nonnull ShareGoodsModel *)dto complete:(nonnull void (^)(ShareStatusModel * _Nonnull, BOOL))completionHandler {
    NSMutableArray* shareArr = [self.shares objectForKey:type];
    if(shareArr.count==1){
        [shareArr[0] shareTypeWithType:type shareData:dto complete:completionHandler];
    }
}

@end
 

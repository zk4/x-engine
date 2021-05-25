//
//  Native_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share.h"
#import "XENativeContext.h"
#import "iShare.h"

@implementation ShareInfoModel


@end
@implementation ContentModel

@end

///NEW
@implementation OpenShareUiDTONav



@end

@implementation ChannelDTONav



@end

@implementation ChannelStatusDTONav



@end

@implementation PosterDTONav



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

- (void)shareTypeWithType:(nonnull NSString *)type shareData:(nonnull ShareInfoModel *)dto complete:(nonnull void (^)(BOOL))completionHandler {
    NSMutableArray* shareArr = [self.shares objectForKey:type];
    if(shareArr.count==1){
        [shareArr[0] shareTypeWithType:type shareData:dto complete:completionHandler];
    }
}

- (void)shareTypeWithType:(NSString *)type shareImage:(UIImage *)image complete:(void (^)(BOOL complete)) completionHandler{
    NSMutableArray* shareArr = [self.shares objectForKey:type];
    if(shareArr.count==1){
        [shareArr[0] shareTypeWithType:type shareImage:image complete:completionHandler];
    }
}
@end
 

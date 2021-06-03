//
//  JSI_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_share.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iShare.h"

@interface JSI_share()
@property(nonatomic, strong) id<iShare> ishare;
@end

@implementation JSI_share
JSI_MODULE(JSI_share)

- (void)afterAllJSIModuleInited {
    self.ishare = XENP(iShare);
}

- (void)_share:(ShareDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self.ishare shareWithType:dto.type channel:dto.channel posterInfo:dto.info complete:^(NSString * _Nullable channel, NSString * _Nullable shareType, NSString * _Nullable imageData, BOOL complete) {
        completionHandler(true);
    }];
}
@end

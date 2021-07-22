//
//  JSI_share.m
//  share
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_share.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iShareManager.h"

@interface JSI_share()
@property(nonatomic, strong) id<iShareManager> ishareManager;
@end

@implementation JSI_share
JSI_MODULE(JSI_share)

- (void)afterAllJSIModuleInited {
    self.ishareManager = XENP(iShareManager);
}

- (void)_share:(ShareDTO *)dto complete:(void (^)(BOOL))completionHandler {

    [self.ishareManager shareWithType:dto.type channel:dto.channel posterInfo:dto.info complete:^(  BOOL complete) {
        completionHandler(TRUE);
    }];
}
@end

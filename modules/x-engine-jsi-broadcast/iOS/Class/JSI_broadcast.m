//
//  JSI_broadcast.m
//  broadcast
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_broadcast.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iBroadcast.h"

@interface JSI_broadcast()
@property (nonatomic, strong)   id<iBroadcast>  broadcast;

@end

@implementation JSI_broadcast
JSI_MODULE(JSI_broadcast)

- (void)afterAllJSIModuleInited {
    _broadcast = XENP(iBroadcast);

}

   
  
 
- (void)_triggerBroadcast:(_triggerBroadcast_com_zkty_jsi_broadcast_0_DTO *)dto {
    [_broadcast broadcast:dto.type  payload:dto.payload];

}

// 测试用, 不应该使用
- (void)_triggerNativeBroadcastNull {
    [_broadcast broadcast:@"native_null"  payload:[NSNull null]];
}


@end

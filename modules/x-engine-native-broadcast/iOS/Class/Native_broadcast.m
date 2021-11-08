//
//  Native_broadcast.m
//  broadcast
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 x-engine. All rights reserved.


#import "Native_broadcast.h"
#import "XENativeContext.h"
#import "WebViewFactory.h"
#import "XEngineWebView.h"

@interface Native_broadcast()
{ }
@end

@implementation Native_broadcast
NATIVE_MODULE(Native_broadcast)

 - (NSString*) moduleId{
    return @"com.zkty.native.broadcast";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 

-(void) broadcast:(NSString*) type payload:(NSString*) payload{
    for (XEngineWebView* wv in [WebViewFactory sharedInstance].webviews){
        if(wv){
            [wv callHandler:@"com.zkty.module.engine.broadcast" arguments:@{
                @"type":type,
                @"payload":payload
            }
             completionHandler:^(id  _Nullable value) {
                NSLog(@"js broadcast ret value %@",value);
            }];
        }
    }
}
@end
 

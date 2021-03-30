//
//  JSIBroadcastModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIBroadcastModule.h"
#import "JSIContext.h"
#import "NativeContext.h"
#import "Broadcast.h"
@interface JSIBroadcastModule ()
 @end
@implementation JSIBroadcastModule
JSI_MODULE(JSIBroadcastModule)

- (NSString*) moduleId{
    return @"com.zkty.jsi.broadcast";
}

-(void)afterAllJSIModuleInited {
 }
- (void) trigger:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    if([dict[@"source"] isEqualToString:@"2"])
        [Broadcast broadcast:@{@"to":@"1",@"payload":@"hello,from 2"}];
    if([dict[@"source"] isEqualToString:@"1"])
    {
        NSLog(@"return from 1!!!!!");
    }
}
@end

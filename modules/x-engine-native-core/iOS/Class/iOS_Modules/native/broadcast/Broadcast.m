//
//  Broadcast.m



#import "Broadcast.h"
#import "Unity.h"
#import "micros.h"
#import "GlobalState.h"
#import "XEOneWebViewPool.h"
#import "NativeContext.h"

@implementation Broadcast
NATIVE_MODULE(Broadcast)
- (NSString*) moduleId{
    return @"com.zkty.native.broadcaset";
}
+ (void)broadcast:(NSString*) payload{
     for (XEOneWebViewPoolModel* wv in [XEOneWebViewPool sharedInstance].webCacheAry){
        [wv.webView callHandler:@"com.zkty.module.engine.broadcast" arguments:payload completionHandler:^(id  _Nullable value) {
            NSLog(@"js return value %@",value);
        }];
    }
}
@end

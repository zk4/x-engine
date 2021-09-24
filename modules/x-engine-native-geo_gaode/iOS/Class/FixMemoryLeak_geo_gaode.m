
#import "FixMemoryLeak_geo_gaode.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "XTool.h"
 
@interface AMapStatistics (MemoryLeak_fix)

@end

@implementation AMapStatistics (MemoryLeak_fix)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [XToolRuntime addInstanceFunc:[AMapStatistics class]
                                    fakeClass:[AMapStatistics class]
                                   withOldSel:@selector(fetchSSIDInfo)
                                   withNewSel:@selector(fetchSSIDInfo2)];
    });
}

-(id)fetchSSIDInfo2
{
    // 这个高德的方法会内存泄漏 [AMapStatistics fetchSSIDInfo]
    // 原因 https://juejin.cn/post/6938305386684350495，拿 wifi 想做什么，不让拿！
    return nil ;
}

@end

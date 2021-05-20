//
//  Native_share_wx.m
//  share_wx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_share_wx.h"
#import "NativeContext.h"
#import "Native_share.h"
@interface Native_share_wx()
{ }
@end

@implementation Native_share_wx
NATIVE_MODULE(Native_share_wx)

 - (NSString*) moduleId{
    return @"com.zkty.native.share_wx";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 
-(NSString*) test{
    return @"test";
}

- (NSString * _Nullable)getIconUrl {
    return  @"";
}

- (NSString * _Nullable)getName {
    return @"native.share_wx";
}

- (NSArray<NSString *> * _Nullable)getTypes {
    return @[@"wx_friend",@"wx_zone",@"gome",@"create_poster",@"save_img"];
}

- (void)shareTypeWithType:(nonnull NSString *)type shareData:(nonnull ShareGoodsModel *)dto complete:(nonnull void (^)(ShareStatusModel * _Nonnull, BOOL))completionHandler {
    ShareStatusModel *mode  = [[ShareStatusModel alloc]init];
    mode.resultCode         = @"200";
    mode.resultMessage      = @"分享成功";
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:type message:[dto description] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    completionHandler(mode,YES);
}





@end
 

//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iShare.h"
 
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id<iShare> sharewx= XENP(iShare);
//    [sharewx shareWithType:@"miniProgram" channel:@"wx_friend" posterInfo:
//     @{
//         @"imgData" : @"https://pic1.zhimg.com/80/v2-3c49d29ca5d8a19baaf6ccb498309ea0_1440w.jpg",
//         @"userName" : @"gh_bf12178b86e9",
//         @"title" : @"给您分享了【测试商品不发货勿拍】摩飞榨汁机",
//         @"link" : @1,
//         @"miniProgramType" : @0,
//         @"path" : @"/pages/goodDetailWebview/goodDetailWebview?webviewUrl=%2FgoodsDetail%3FshopCode%3DGMJ-MS-2UKJT-JT2%26skuCode%3D1000000000019%26mallCode%3DG02T%26cityCode%3D110100",
//         @"desc" : @"分享商品"
//       } complete:^(BOOL complete) {
//        NSLog(@"");
//    }];

    [sharewx shareWithType:@"img" channel:@"wx_zone" posterInfo:
     @{
         @"imgData" : @"https://pic1.zhimg.com/80/v2-3c49d29ca5d8a19baaf6ccb498309ea0_1440w.jpg",
         @"userName" : @"gh_bf12178b86e9",
         @"title" : @"给您分享了【测试商品不发货勿拍】摩飞榨汁机",
         @"link" : @1,
         @"miniProgramType" : @0,
         @"path" : @"/pages/goodDetailWebview/goodDetailWebview?webviewUrl=%2FgoodsDetail%3FshopCode%3DGMJ-MS-2UKJT-JT2%26skuCode%3D1000000000019%26mallCode%3DG02T%26cityCode%3D110100",
         @"desc" : @"分享商品"
       } complete:^(BOOL complete) {
        NSLog(@"");
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end

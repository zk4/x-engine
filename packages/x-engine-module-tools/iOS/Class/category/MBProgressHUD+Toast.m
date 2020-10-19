//
//  MBProgressHUD+Toast.m
//  XEngine

#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+Toast.h"
#import "Unity.h"

@implementation MBProgressHUD (Toast)
+ (MBProgressHUD *)showToastWithTitle:(NSString *)title image:(UIImage *)image time:(NSTimeInterval)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[Unity sharedInstance].topView animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    if (image)
    {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }else
    {
        hud.mode = MBProgressHUDModeText;
    }
    hud.label.text = title;
    [hud hideAnimated:YES afterDelay:time];
//    hud.minShowTime = time;
    return hud;
}
@end

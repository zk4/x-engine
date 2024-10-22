//
//  Native_scan__hms.m
//  scan__hms
//


#import "Native_scan__hms.h"
#import "XENativeContext.h"
//#import <ScanKitFrameWork/ScanKitFrameWork.h>
#import <ScanKitFrameWork/HmsCustomScanViewController.h>
#import "QRCodeScanPreviewView.h"

#import "MBProgressHUD.h"
#include "iDirectManager.h"
#include <Unity.h>
#import <Masonry/Masonry.h>
 
typedef void (^xScanBlock)(NSString *);
@interface Native_scan__hms() <CustomizedScanDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSTimer *_timer;
}
@property ( nonatomic) __block xScanBlock block;
@property (nonatomic, strong) HmsCustomScanViewController *hmsCustomScanViewController;
@property (nonatomic, strong) QRCodeScanPreviewView *scanView;
@property (nonatomic, assign) CGRect areaRect;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSString *routeUrl;
@property (nonatomic, assign) BOOL isBack;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isOnTopView;
@end

@implementation Native_scan__hms
NATIVE_MODULE(Native_scan__hms)

 - (NSString*) moduleId{
    return @"com.zkty.native.scan__hms";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNativePush:) name:@"GMJNativePushNotification" object:nil];

    
} 
 
- (void)openScanView:(NSString *)routeUrl complete:(void (^)(NSString * res))completionHandler{
    self.isOnTopView = YES;
    self.isBack = YES;
    self.routeUrl = routeUrl;
    [self openScanView:^(NSString *res) {
        completionHandler(res);
    }];
  
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf && weakSelf.isOnTopView) {
            [weakSelf addRichText];
        }
     
    });
}
-(void)onNativePush:(NSNotification *)noti{
    if (_timer) {
        [self stopTimer:_timer];
      
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GMJNativePushNotification" object:nil];
    }
   
    
}
-(void)addRichText{
    

    UIView *superV = [Unity sharedInstance].getCurrentVC.view;
    _superView =superV;
    
    if ([superV.subviews containsObject:_tipView]) {
        return;
    }
    _tipView = [[UIView alloc] init];
    _tipView.tag=999998;
    _tipView.hidden = NO;
    _tipView.backgroundColor = [UIColor whiteColor];
    _tipView.layer.cornerRadius = 5;
    [superV addSubview:_tipView];

    [_tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superV.mas_left).offset(15);
        make.right.equalTo(superV.mas_right).offset(-15);
        make.bottom.equalTo(superV.mas_bottom).offset(-40);
        make.height.equalTo(@80);
    }];
  
    
    UILabel *tipLB  = [[UILabel alloc] init];
//    tipLB.frame = CGRectMake(20, [Unity sharedInstance].getCurrentVC.view.frame.size.height-100, [Unity sharedInstance].getCurrentVC.view.frame.size.width-40, 80);
    tipLB.layer.masksToBounds = YES;
    
    tipLB.text = @"本功能可以扫的码有：会员码、团购码等。如果扫码不成功，可尝试手工输入码号。点我手工输入码号";
    tipLB.textColor = [UIColor blackColor];
    tipLB.numberOfLines = 0;
    tipLB.backgroundColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentLeft;
    
    NSRange range = [tipLB.text rangeOfString:@"点我手工输入码号"];
    
    [self richTextLabel:tipLB FontNumber:[UIFont systemFontOfSize:15] AndRange:range AndColor:[UIColor blueColor]];
    
    [_tipView addSubview:tipLB];
    
    tipLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [tipLB addGestureRecognizer:tap];
   
    
    [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tipView.mas_left).offset(10);
        make.right.equalTo(_tipView.mas_right).offset(-10);
        make.top.equalTo(_tipView.mas_top).offset(10);
    }];

}
-(void)tap:(UITapGestureRecognizer *)tap{
    
    id<iDirectManager> customDirect = XENP(iDirectManager);

    [customDirect push:self.routeUrl params:@{@"hideNavbar":@"YES"}];
}
-(void)richTextLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    labell.attributedText = str;
}
- (void)openScanView:(void (^)(NSString *))completionHandler {
    
    /*
      AVAuthorizationStatusNotDetermined 没有对应用程序授权进行操作
      AVAuthorizationStatusRestricted    没有授权访问的照片数据
      AVAuthorizationStatusDenied        用户拒绝对应用程序授权
      AVAuthorizationStatusAuthorized    用户对应用程序授权
    */
    NSString *mediaType = AVMediaTypeVideo; //读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType]; //读取设备授权状态
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) { // 授权受阻
        UIAlertController *alterCon = [UIAlertController alertControllerWithTitle:@"乐活秀需要访问您的相机，请前往设置页面打开授权,如不允许，您将无法扫码"
                                                                          message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OFF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *ON = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { // 设置权限
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    // do something
                }];
            }
        }];
        [alterCon addAction:OFF];
        [alterCon addAction:ON];
        [[Unity sharedInstance].getCurrentVC presentViewController:alterCon animated:YES completion:nil];
        return;
    }
    
    //初始化扫码能力
    BOOL photoMode = true;
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:QR_CODE | DATA_MATRIX | AZTEC | CODABAR | CODE_39 | CODE_93 | CODE_128 | EAN_8 | EAN_13 | ITF | PDF_417 | UPC_A | UPC_E | ALL  Photo:photoMode];
    HmsCustomScanViewController *hmsCustomScanViewController = [[HmsCustomScanViewController alloc] initCustomizedScanWithFormatType:options];
    hmsCustomScanViewController.customizedScanDelegate = self;
    hmsCustomScanViewController.backButtonHidden = YES;

    hmsCustomScanViewController.modalPresentationStyle = 0;
    if (self.routeUrl) {
        [[Unity sharedInstance].getCurrentVC.navigationController pushViewController:hmsCustomScanViewController animated:YES];

    }else{
        [[Unity sharedInstance].getCurrentVC presentViewController:hmsCustomScanViewController animated:YES completion:^{}];

    }
    self.hmsCustomScanViewController = hmsCustomScanViewController;
    
    //扫码区域
    CGRect areaRect = CGRectMake(([Unity sharedInstance].getCurrentVC.view.frame.size.width - 300)/2, ([Unity sharedInstance].getCurrentVC.view.frame.size.height - 300)/2, 300, 300);
    self.areaRect = areaRect;
    QRCodeScanPreviewView *scanView = [[QRCodeScanPreviewView alloc]initWithFrame:[Unity sharedInstance].getCurrentVC.view.bounds];
    scanView.scanFrame = areaRect;
    [self.hmsCustomScanViewController.view addSubview:scanView];
    self.scanView = scanView;
    
    //绘制扫码区边框、动画
    [self configView];
    
    //开始扫码动画
    [_timer setFireDate:[NSDate date]];
    
    //定制导航按钮
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(-20, statusBarFrame.size.height, 100, 100);
    [backButton setImage:[UIImage imageNamed:@"personal_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [[Unity sharedInstance].getCurrentVC.view addSubview:backButton];
    //右侧按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake([Unity sharedInstance].getCurrentVC.view.frame.size.width-80, statusBarFrame.size.height, 100, 100);
    [rightButton setImage:[UIImage imageNamed:@"tupian"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [[Unity sharedInstance].getCurrentVC.view addSubview:rightButton];

   // 隐藏导航栏。
    self.block = completionHandler;
}

- (void)configView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.areaRect];
    [shapeLayer setPosition:CGPointMake(self.areaRect.origin.x + self.areaRect.size.width * 0.5, self.areaRect.origin.y + self.areaRect.size.height * 0.5)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置边框颜色
    [shapeLayer setStrokeColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:255/255.0f alpha:0.7].CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:3];
    [shapeLayer setLineJoin:kCALineJoinMiter];

    //左上角
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,
                      NULL,
                      self.areaRect.origin.x - 1,
                      self.areaRect.origin.y + 20);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x - 1,
                         self.areaRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x + 20,
                         self.areaRect.origin.y - 1);
    //右上角
    CGPathMoveToPoint(path,
                      NULL,
                      self.areaRect.origin.x + self.areaRect.size.width - 20,
                      self.areaRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x + self.areaRect.size.width + 1,
                         self.areaRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x + self.areaRect.size.width + 1,
                         self.areaRect.origin.y + 20);
    //左下角
    CGPathMoveToPoint(path,
                      NULL,
                      self.areaRect.origin.x + self.areaRect.size.width + 1,
                      self.areaRect.origin.y + self.areaRect.size.width - 20);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x + self.areaRect.size.width + 1,
                         self.areaRect.origin.y + self.areaRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x + self.areaRect.size.width - 20,
                         self.areaRect.origin.y + self.areaRect.size.width + 1);
    //右下角
    CGPathMoveToPoint(path,
                      NULL,
                      self.areaRect.origin.x + 20,
                      self.areaRect.origin.y + self.areaRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x - 1,
                         self.areaRect.origin.y + self.areaRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.areaRect.origin.x - 1,
                         self.areaRect.origin.y + self.areaRect.size.width - 20);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.hmsCustomScanViewController.view.layer addSublayer:shapeLayer];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(self.areaRect.origin.x-10,
                                                          self.areaRect.origin.y,
                                                          self.areaRect.size.width+20,
                                                          3)];
    [_line setImage:[UIImage imageNamed:@"scanLine"]];
    [self.hmsCustomScanViewController.view addSubview:_line];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                             target:self
                                           selector:@selector(animation)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)animation {
    if(_line.frame.origin.y >= (self.areaRect.origin.y + self.areaRect.size.height) - 2){
        CGRect frame = _line.frame;
        frame.origin.y = self.areaRect.origin.y;
        _line.frame = frame;
    } else {
        CGRect frame = _line.frame;
        frame.origin.y = _line.frame.origin.y + (self.areaRect.size.height) / 200;
        _line.frame = frame;
    }
}
//右侧按钮 选择图片
- (void)rightAction:(UIButton *)senderm {
    [self imagePickersource];
}

- (void)backAction:(UIButton *)sender {
    self.isBack = NO;
    [self stopTimer:_timer];
    if(self.routeUrl) {
        [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];

    }else{
        [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:YES completion:^{
                //自定义按钮中绑定返回操作
                [self.hmsCustomScanViewController backAction];
            }];

    }

    [self.hmsCustomScanViewController backAction];
}


- (void)imagePickersource {
    if (self.imagePickerController == nil) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        self.imagePickerController.allowsEditing = NO;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [[Unity sharedInstance].getCurrentVC presentViewController:self.imagePickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self showLoading:@"正在处理"];
    ///耗时操作
    NSDictionary *dic = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    NSString *jsonStr = @"";
    if (dic) {
        jsonStr =  dic[@"text"];
    }
    ///先销毁图片选择页面
    [picker dismissViewControllerAnimated:YES completion:^{
        [self removeHud];
        self.block(jsonStr?jsonStr:@"");
//        [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:NO completion:^{}];
        
        
        if(self.routeUrl) {
           
            [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];

        }else{
            [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:YES completion:^{
                    //自定义按钮中绑定返回操作
                }];
        }
    }];
}

- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* jsonStr =  resultDic[@"text"];
        
        if(self.routeUrl) {
         
            [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.block(jsonStr?jsonStr:@"");
            });

        }else{
            [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    self.block(jsonStr?jsonStr:@"");
                });
                

            
            }];
        }
       

   });
}

- (void)stopTimer:(NSTimer *)t{
    self.isOnTopView = NO;
    [t setFireDate:[NSDate distantFuture]];
    [t invalidate];
    t = nil;
    
    if ([_superView.subviews containsObject:_tipView]) {
        _tipView.hidden = YES;
        [_tipView removeFromSuperview];
        _tipView = nil;
    }
//    for(id tmpView in _superView.subviews)
//    {
//        //找到要删除的子视图的对象
//        if([tmpView isKindOfClass:[UIView class]])
//        {   UIView *v = (UIView *)tmpView;
//
//            if(v.tag == 999998)
//            {
//                [tmpView removeFromSuperview];
//                break;
//            }
//        }
//    }
//
  
}

- (void)showLoading:(NSString *)tip{
    [self removeHud];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.text = tip;
    self.hud.label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.color = [UIColor blackColor];
    
    self.hud = hud;
}
- (void)removeHud{
    if(self.hud){
        self.hud.removeFromSuperViewOnHide = YES;
        [self.hud hideAnimated:YES];
    }
}
/*DefaultScan Delegate
  Data returned by album pictures
 */
- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
   // TODO: iScan 没这个功能
}
-(void)dealloc {
    self.isBack = NO;
}
@end
 

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

#include <Unity.h>
 
typedef void (^xScanBlock)(NSString *);
@interface Native_scan__hms() <CustomizedScanDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSTimer *_timer;
}
@property ( nonatomic) xScanBlock block;
@property (nonatomic, strong) HmsCustomScanViewController *hmsCustomScanViewController;
@property (nonatomic, strong) QRCodeScanPreviewView *scanView;
@property (nonatomic, assign) CGRect areaRect;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) MBProgressHUD *hud;

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
    
} 
 
- (void)openScanView:(void (^)(NSString *))completionHandler {
    
    //初始化扫码能力
    BOOL photoMode = true;
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:QR_CODE | DATA_MATRIX Photo:photoMode];
    HmsCustomScanViewController *hmsCustomScanViewController = [[HmsCustomScanViewController alloc] initCustomizedScanWithFormatType:options];
    hmsCustomScanViewController.customizedScanDelegate = self;
    hmsCustomScanViewController.backButtonHidden = true;
    hmsCustomScanViewController.modalPresentationStyle = 0;
    [[Unity sharedInstance].getCurrentVC presentViewController:hmsCustomScanViewController animated:YES completion:^{}];
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
    [self stopTimer:_timer];
    [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:YES completion:^{
        //自定义按钮中绑定返回操作
        [self.hmsCustomScanViewController backAction];
    }];
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
        [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:NO completion:^{}];
    }];
}

- (void)customizedScanDelegateForResult:(NSDictionary *)resultDic{
    //不是所有的地方都需要弱Timer
    __block NSTimer *timer;
    timer = _timer;
    dispatch_async(dispatch_get_main_queue(), ^{
     // 在主线程内处理数据
        [self stopTimer:timer];
        NSString* jsonStr =  resultDic[@"text"];
        self.block(jsonStr?jsonStr:@"");
        [[Unity sharedInstance].getCurrentVC dismissViewControllerAnimated:NO completion:^{}];

   });
}

- (void)stopTimer:(NSTimer *)t{
    [t setFireDate:[NSDate distantFuture]];
    [t invalidate];
    t = nil;
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
@end
 

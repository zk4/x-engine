//
//  ScanViewController.m
//  x-engine-native-scan
//
//  Created by cwz on 2021/4/16.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "ZBarSDK.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds


@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZBarReaderViewDelegate>{
    int num;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic) ZBarReaderView *rederView;
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, strong) UILabel *qrTipLabel;
@property (nonatomic, strong) UIButton *mineQRBtn;
@property (nonatomic, assign) CGRect windowRect;
@property (nonatomic, assign) BOOL is;
@end

@implementation ScanViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.title = @"扫描二维码";
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self initCQView];
        }
    } else if(status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
    } else {

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initCQView];
                    });
                }
            }
        }];
    }
}

- (void)initCQView{
    float viewWidth = self.view.bounds.size.width - 125;
    self.windowRect = CGRectMake((self.view.bounds.size.width - viewWidth) * 0.5,
                                 (self.view.bounds.size.height - viewWidth) * 0.5,
                                 viewWidth,
                                 viewWidth);
    [self setCropRect:self.windowRect];
    [self configView];
    [self setupCamera];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)configView{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.windowRect];
    [shapeLayer setPosition:CGPointMake(self.windowRect.origin.x + self.windowRect.size.width * 0.5,
                                        self.windowRect.origin.y + self.windowRect.size.height * 0.5)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[UIColor blueColor].CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:4];
    [shapeLayer setLineJoin:kCALineJoinMiter];
    
    //左上角
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,
                      NULL,
                      self.windowRect.origin.x - 1,
                      self.windowRect.origin.y + 20);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x - 1,
                         self.windowRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x + 20,
                         self.windowRect.origin.y - 1);
    //右上角
    CGPathMoveToPoint(path,
                      NULL,
                      self.windowRect.origin.x + self.windowRect.size.width - 20,
                      self.windowRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x + self.windowRect.size.width + 1,
                         self.windowRect.origin.y - 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x + self.windowRect.size.width + 1,
                         self.windowRect.origin.y + 20);
    //左下角
    CGPathMoveToPoint(path,
                      NULL,
                      self.windowRect.origin.x + self.windowRect.size.width + 1,
                      self.windowRect.origin.y + self.windowRect.size.width - 20);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x + self.windowRect.size.width + 1,
                         self.windowRect.origin.y + self.windowRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x + self.windowRect.size.width - 20,
                         self.windowRect.origin.y + self.windowRect.size.width + 1);
    //右下角
    CGPathMoveToPoint(path,
                      NULL,
                      self.windowRect.origin.x + 20,
                      self.windowRect.origin.y + self.windowRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x - 1,
                         self.windowRect.origin.y + self.windowRect.size.width + 1);
    CGPathAddLineToPoint(path,
                         NULL,
                         self.windowRect.origin.x - 1,
                         self.windowRect.origin.y + self.windowRect.size.width - 20);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.view.layer addSublayer:shapeLayer];
    
    num = 0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(self.windowRect.origin.x,
                                                          self.windowRect.origin.y + 10,
                                                          self.windowRect.size.width,
                                                          2)];
    _line.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_line];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                             target:self
                                           selector:@selector(animation)
                                           userInfo:nil
                                            repeats:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.rederView start];
    [timer setFireDate:[NSDate date]];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.rederView stop];
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)animation {
//    if(_line.top >= (self.windowRect.origin.y + self.windowRect.size.height) - 2){
//        _line.top = self.windowRect.origin.y;
//    } else {
//        _line.top = _line.top + self.windowRect.size.height / 200;
//    }
}

- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
//    [cropLayer setFillColor:[WYColorUtil btnBackgroundGray].CGColor];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.3];
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{
    
    [self scanImageToData:symbols];
}

- (void)scanImageToData:(ZBarSymbolSet *)symbols{
    [AVCapturePhotoSettings photoSettings].flashMode = AVCaptureFlashModeOff;
    for (ZBarSymbol *bol in symbols) {
        [[self getCurrentVC].navigationController popViewControllerAnimated:YES];
        if(self.callBack){
            self.callBack(bol.data);
        }
        return;
    }
}

- (void)readerViewDidStart: (ZBarReaderView*) readerView{}

- (void) readerView: (ZBarReaderView*) readerView
   didStopWithError: (NSError*) error{
}

-(void)setupCamera{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.rederView = [[ZBarReaderView alloc] init];
    self.rederView.torchMode = 0;
    self.rederView.tracksSymbols = NO;
    self.rederView.readerDelegate = self;
    self.rederView.frame = self.view.bounds;
    self.rederView.backgroundColor = [UIColor whiteColor];
    NSError *err;
    [self.rederView.device lockForConfiguration:&err];
    if(err == nil){
        [self.rederView.device setTorchMode:AVCaptureTorchModeOff];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.rederView.device.flashMode = AVCaptureFlashModeOff;
#pragma clang diagnostic pop
        [AVCapturePhotoSettings photoSettings].flashMode = AVCaptureFlashModeOff;
    }
    [self.rederView.device unlockForConfiguration];
    [self.rederView start];
    [self.view insertSubview:self.rederView atIndex:0];
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UINavigationController *nav = (UINavigationController *)rootVC;
        currentVC = [self getCurrentVCFrom:[nav topViewController]];
        //        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}
@end

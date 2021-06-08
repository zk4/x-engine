//
//  micros.h
//  Pods


#ifndef micros_h
#define micros_h

#define kBundle                 [NSBundle mainBundle]
#define kDevice                 [UIDevice currentDevice]
#define kKeyWindow              kApplication.keyWindow
#define kRootVC                 kApplication.keyWindow.rootViewController
#define kScreenBounds           [UIScreen mainScreen].bounds

#define kFileManager            [NSFileManager defaultManager]
#define kApplication            [UIApplication sharedApplication]
#define kNotificationCenter     [NSNotificationCenter defaultCenter]
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
#define kWidth                  (kScreenBounds.size.width)
#define kHeight                 (kScreenBounds.size.height)
#define kVersion                [kDevice systemVersion]

#define kIPHONE4                (kScreenBounds.size.height == 480)           // 设备4
#define kIPHONE5                (kScreenBounds.size.height == 568)           // 设备5
#define kIPHONE6S               (kScreenBounds.size.height == 667)           // 设备6  6s  7  高度
#define kIPHONE6SP              (kScreenBounds.size.height == 736)           // 设备6p 6sp 7p 高度
#define kIPHONEX                (kScreenBounds.size.height > 736)            // 设备6p 6sp 7p 高度

#define kIOS9                   (kVersion.integerValue == 9)                 // iOS9
#define kIOS10                  (kVersion.integerValue == 10)                // iOS10
#define kIOS11                  (kVersion.integerValue == 11)                // iOS11
#define kIOS12                  (kVersion.integerValue == 12)                // iOS12

#define kStatusBarH             (CGFloat)(kIPHONEX?(44):(20))                // 状态栏高度
#define kNavigationH            (CGFloat)(kIPHONEX?(88):(64))                // 状态栏和导航栏总高度
#define kTabBarH                (CGFloat)(kIPHONEX?(49):(49))                // TabBar高度
#define kBottomSafeHeight       (CGFloat)(kIPHONEX?(34):(0))                 // 底部安全区域远离高度


#define kEEEEEFColor            [UIColor colorWithHexString:@"EEEEEF"]
#define kF7F7F7Color            [UIColor colorWithHexString:@"F7F7F7"]
#define kRGBColor(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kRGBAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define DLog(fmt, ...)          do{NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}while(false);

#define perfTime                do{NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];\
                                [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];\
                                NSString *date =  [formatter stringFromDate:[NSDate date]];\
                                NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];\
                                DLog(@"%@", timeLocal);}while(false);

#define perfTimeTag(tag)        do{NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];\
                                [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];\
                                NSString *date =  [formatter stringFromDate:[NSDate date]];\
                                NSString *timeLocal = [[NSString alloc] initWithFormat:@"#%s# %@", tag, date];\
                                DLog(@"%@", timeLocal);}while(false);

#define perfTimeFunc(func)        do{NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];\
                                [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];\
                                NSString *date =  [formatter stringFromDate:[NSDate date]];\
                                NSString *timeLocal = [[NSString alloc] initWithFormat:@"#%s# %@", tag, date];\
                                func \
                                DLog(@"%@", timeLocal);}while(false);

#define perfStart(tag)               CFAbsoluteTime tag =CFAbsoluteTimeGetCurrent();
#define perfEnd(tag)                 NSLog(@"%s in %f ms",#tag, (CFAbsoluteTimeGetCurrent() - tag) *1000.0);

#define NSLog(FORMAT, ...) do{fprintf(stderr,"%s:%d\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);}while(false);


#define OffLineHtmlFilePathKey @"htmlFilePathKey"
//#define OffLinePreferencesPathKey @"PreferencesPath"
#define ObjErrorCheck(obj)             [NSString stringWithFormat:@"%@", (obj && ![obj isKindOfClass:[NSNull class]]) ? obj : @""]

#define SetAssociatedObject(key, value) objc_setAssociatedObject(self, &key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define GetAssociatedObject(key)        objc_getAssociatedObject(self, &key)
// User Defaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define USER_DEFAULT_SETTER(obj,key) \
[USER_DEFAULT setObject:obj forKey:key];\
\
[USER_DEFAULT synchronize];

#define WeakObj(o) __weak typeof(o) Weak##o = o;

#define APP_VERSION            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_NAME               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_BUNDLE_ID          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define SYSTEM_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]

#define NSStringFromInt(intValue)               [NSString stringWithFormat:@"%d", (int)(intValue)]
#define NSStringFromNSInteger(integerValue)     [NSString stringWithFormat:@"%ld", (long)(integerValue)]
#define NSStringFromNSUInteger(uintegerValue)   [NSString stringWithFormat:@"%lu", (unsigned long)(uintegerValue)]
#define NSStringFromLongLongInt(llInt)          [NSString stringWithFormat:@"%lld", llInt]
#define NSStringFromUnsignedLongLongInt(ullInt) [NSString stringWithFormat:@"%llu", ullInt]
#define NSStringFromCGFloat(floatValue)         [[NSNumber numberWithFloat:floatValue] stringValue]
#define NSStringFromDouble(doubleValue)         [[NSNumber numberWithDouble:doubleValue] stringValue]

#define RGBCOLOR(r,g,b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBSCOLOR(sameValue)   [UIColor colorWithRed:(sameValue)/255.0 green:(sameValue)/255.0 blue:(sameValue)/255.0 alpha:1]
#define RGBVCOLOR(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)\
((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 屏幕属性：宽 高 缩放比
#define SCREEN_WIDTH                   ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                  ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE                   ([UIScreen mainScreen].scale)

#define ONE_PIXEL                      (1.0/SCREEN_SCALE)

// 状态栏高度
#define STATUS_BAR_HEIGHT              CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])

// 导航栏高度
#define NAVIGATION_BAR_HEIGHT          44.0

// 切换栏高度
#define TAB_BAR_HEIGHT                 49.0

// 安全区
#define SAFE_AREA_INSETS               [[[[UIApplication sharedApplication] delegate] window] safeAreaInsets]
#define SAFE_AREA_LEFT_SPACING         (@available(iOS 11.0, *) ? SAFE_AREA_INSETS.left   : 0.0)
#define SAFE_AREA_RIGHT_SPACING        (@available(iOS 11.0, *) ? SAFE_AREA_INSETS.right  : 0.0)
#define SAFE_AREA_TOP_SPACING          (@available(iOS 11.0, *) ? SAFE_AREA_INSETS.top    : 0.0)
#define SAFE_AREA_BOTTOM_SPACING       (@available(iOS 11.0, *) ? SAFE_AREA_INSETS.bottom : 0.0)
#define SAFE_AREA_SIDE_SPACING         fmax(SAFE_AREA_LEFT_SPACING, SAFE_AREA_RIGHT_SPACING)

// 切换栏区域
#define TAB_BAR_AREA_HEIGHT            (TAB_BAR_HEIGHT + SAFE_AREA_BOTTOM_SPACING)

// 是否是全面屏（如iphoneX）
#define IS_ALL_SCREEN_DEVICE           (@available(iOS 11.0, *) ? SAFE_AREA_INSETS.bottom > 0.0 : NO)

// 是否是 iPhone Plus
#define IS_IPHONE_PLUS                 ((MIN(SCREEN_WIDTH, SCREEN_HEIGHT)) >= 414)

// 导航栏元素距离屏幕边距
#define PREFERRED_SCREEN_SIDE_SPACING  (IS_IPHONE_PLUS ? 20.0 : 16.0)

typedef void (^XEngineCallBack)(id _Nullable result,BOOL complete);

#define XE_CONCAT(a,b) a##b

#define WeakSelf(type) __weak typeof(type) weak##type = type;
#define WeakSelfNamed(type,name) __weak typeof(type) weak##type##name = type;
#define StrongSelfNamed(type,name) __strong typeof(type) type = weak##type##name;

#define StrongSelf(type) __strong typeof(type) type = weak##type;


#define XE_ALERT(msg)\
do{\
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",msg] preferredStyle:UIAlertControllerStyleAlert];\
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
    }];\
    [errorAlert addAction:sureAction];\
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:errorAlert animated:YES completion:^{\
    }];\
}while(0)


#endif /* micros_h */

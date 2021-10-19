//
//   XTool.h
//  只允许静态方法暴露, 不允许维护状态
#import <UIKit/UIKit.h>

@interface  XToolError : NSObject
// iOS更优雅的NSError的处理流程, 能够记住每一层的 NSError
// https://www.jianshu.com/p/2e9081da0391
+ (NSError *) wrapper:(NSError *)error  underlyingError:(NSError *) underlyingError;
@end

@interface  XToolAlert: NSObject
+ (void)alert:(NSString *)message;
@end


@interface  XToolImage: NSObject
/// 尽量按高质量压缩图片到你要的结果
/// @param image 源图片
/// @param size 不超过多少尺寸
/// @param q   0 到 1. 最小接受多少压缩质量,在保障尺寸不超 size 的情况下,用最高质量
+ (NSData *)compressImage:(UIImage *)image toMaxDataSizeKBytes:(float)size miniQuality:(float)q;

/// UIImage转base64
/// @param image 图片
+ (NSString *)imageToBase64Str:(UIImage *)image;

/// base64转UIImage
/// @param base64 base64字符串
+ (UIImage *)base64StrToimage:(NSString *)base64;

/// UIImage(png类型)转换为NSData
/// @param image 图片
+ (NSData *)dataToUIImageWithPNG:(UIImage *)image;

/// UIImage(jpeg类型)转换为NSData
/// @param image 图片
/// @param compressionQuality //第二个参数为压缩倍数
+ (NSData *)dataToUIImageWithJPEG:(UIImage *)image WithCompressionQuality:(CGFloat)compressionQuality;

// 图片裁剪
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (NSData *)thumbnail_64kbData:(NSString *)imgurl;
+ (UIImage *)thumbnail_64kb:(NSString *)imgurl;
@end


@interface  XToolDataConverter: NSObject
/// 字典转json格式字符串
/// @param dict 字典
+ (NSString*)dictionaryToJson:(NSDictionary *)dict;

/// json格式字符串转字典:
/// @param jsonString json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/// json格式字符串转字典:
/// @param jsonString json
+ (NSDictionary *)dictionaryWithJsonStringWithError:(NSString *)jsonString error:(NSError**)error;


/// 将 spa 地址转换为标准 url
+ (NSString*)SPAUrl2StandardUrl:(NSString*)raw;


+ (NSString *) md5:(NSData*)body;
@end

@interface XToolRuntime : NSObject
+ (NSArray *) getSubclasses:(Class) parentClass;
+(void)addSelector:(Class)class withOldSel:(SEL)oldSel withNewSel:(SEL)newSel;
+(void)addInstanceFunc:(Class)class fakeClass:(Class)fakeClass withOldSel:(SEL)oldSel withNewSel:(SEL)newSel;
@end


@interface XToolVC :NSObject
// 获取当前控制器
+ (UIViewController*)getCurrentViewController;
@end


@interface  XToolStringConverter: NSObject
/// uuid
+ (NSString *)uuidString;

// 随机数
+ (NSString *)randomString:(NSInteger)number;
@end

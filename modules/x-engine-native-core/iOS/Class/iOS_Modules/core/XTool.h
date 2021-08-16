//
//   XTool.h
//  只允许静态方法暴露, 不允许维护状态
 

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


+(NSData *)thumbnail_64kbData:(NSString *)imgurl;


+ (UIImage *)thumbnail_64kb:(NSString *)imgurl;

@end


@interface  XToolDataConverter: NSObject

/// 转换 dictionary 为 json 字符串
/// @param dic 
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end

#import "XTool.h"
#import "micros.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#pragma mark - 错误处理
@implementation XToolError
+ (NSError *) wrapper:(NSError *)error  underlyingError:(NSError *) underlyingError {
    if (!error) {
        return underlyingError;
    }
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}
@end

#pragma mark - 弹各种框
@implementation  XToolAlert
+ (void)alert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *enter = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:enter];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end

#pragma mark - 图片处理
@implementation  XToolImage
// UIImage转base64
+ (NSString *)imageToBase64Str:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

// base64转UIImage
+ (UIImage *)base64StrToimage:(NSString *)base64 {
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

//UIImage转换为NSData
+ (NSData *)dataToUIImageWithPNG:(UIImage *)image WithCompressionQuality:(CGFloat)compressionQuality {
    NSData *imageData = UIImageJPEGRepresentation(image,1.0f);//第二个参数为压缩倍数
    return  imageData;
}

/// UIImage(png类型)转换为NSData
/// @param image 图片
+ (NSData *)dataToUIImageWithPNG:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    return imageData;
}

/// UIImage(jpeg类型)转换为NSData
/// @param image 图片
/// @param compressionQuality //第二个参数为压缩倍数
+ (NSData *)dataToUIImageWithJPEG:(UIImage *)image WithCompressionQuality:(CGFloat)compressionQuality {
    NSData *imageData = UIImageJPEGRepresentation(image, compressionQuality);
    return imageData;
}
    
// 压缩图片 --> 这个方法性能如屎.
+ (NSData *)compressImage:(UIImage *)image toMaxDataSizeKBytes:(float)size miniQuality:(float)q{
    static float KB = 1024;
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    float preCompressSize = data.length/KB;

    if (data.length/KB < size) {
        NSLog(@"纯转为 jpeg");
        return data;
    }
    perfStart(img)
    // TODO: 预估质量, 没必要循环
    // https://blog.csdn.net/tomatomas/article/details/62235963
    CGFloat compression = q;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length/KB < size * 0.9) {
            min = compression;
        } else if (data.length/KB > size) {
            max = compression;
        } else {
            break;
        }
    }
    

    if (data.length/1024 < size) {
        perfEnd(img)
        NSLog(@"预想:%f ,压缩前大小: %f, 压缩后大小: %lu",size, preCompressSize,data.length/1024);
        return data;
    }
    
    // 大小还没压下来, 只能缩图片尺寸了.
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length/1024 > size && data.length/1024 != lastDataLength) {
        lastDataLength = data.length /1024;
        CGFloat ratio = size / lastDataLength;
        CGSize nextsize = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(nextsize);
        [resultImage drawInRect:CGRectMake(0, 0, nextsize.width, nextsize.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    NSLog(@"预想:%f ,压缩前大小: %f, 压缩后大小: %lu",size, preCompressSize,data.length/1024);
    perfEnd(img)
    return data;
}

+ (NSData *)thumbnail_64kbData:(NSString *)imgurl {
    if(!imgurl){
        return nil;
    }
    UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    NSData*  thumbData = [XToolImage compressImage:desImage toMaxDataSizeKBytes:63.0 miniQuality:1];
    return thumbData;
    
}

+ (UIImage *)thumbnail_64kb:(NSString *)imgurl {
    NSData* data = [self thumbnail_64kbData:imgurl];
    UIImage*  thumbImg = [[UIImage alloc] initWithData:data];
    return thumbImg;
}

+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end


@implementation  XToolDataConverter

+ (NSString *)md5:(NSData*)body {
    if(!body) return @"";
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
        
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(body.bytes, (unsigned int)body.length, md5Buffer);
        
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];

    return output;
}

/// 字典转json格式字符串
/// @param dict 字典
+ (NSString*)dictionaryToJson:(NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSString*)arrayToJson:(NSArray *)array {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/// json格式字符串转字典:
/// @param jsonString json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    NSError* error;
    return [self dictionaryWithJsonStringWithError:jsonString error:&error];
}

+ (NSDictionary *)dictionaryWithJsonStringWithError:(NSString *)jsonString error:(NSError**)error{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:error];
    if(*error) {
        NSLog(@"json解析失败：%@",*error);
        return nil;
    }
    return dic;
}
 
+ (NSString*)SPAUrl2StandardUrl:(NSString*)raw {
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< raw.length;i++){
        char cc= [raw characterAtIndex:i];

        if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
        // 仅当找到 hashtag 后才再找?, 不然不是 SPA url
        if(hashtagMark != -1 && cc == '?' && questionMark == -1){
            questionMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* sub1= [raw substringToIndex:hashtagMark];
        NSString* sub2= [raw substringWithRange:NSMakeRange(hashtagMark, questionMark-hashtagMark)];
        NSString* sub3=[[raw substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
}
 
+ (NSURL*)SPAUrl2StandardUrlWithPort:(NSString*)raw{
    
    NSURL* url = [NSURL URLWithString:[XToolDataConverter SPAUrl2StandardUrl:raw]];

    NSURLComponents * c = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO] ;
        
    NSNumber* port = url.port;
    if(!port){
        if([c.scheme isEqualToString:@"https"])
            c.port = @443;
        else if([url.scheme isEqualToString:@"http"])
            c.port = @80;
    }
     return c.URL;
}
@end




@implementation XToolRuntime

+ (NSArray *) getSubclasses:(Class) parentClass
{
  int numClasses = objc_getClassList(NULL, 0);
  Class *classes = NULL;

  classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
  numClasses = objc_getClassList(classes, numClasses);

  NSMutableArray *result = [NSMutableArray array];
  for (NSInteger i = 0; i < numClasses; i++)
  {
    Class superClass = classes[i];
    do
    {
      superClass = class_getSuperclass(superClass);
    } while(superClass && superClass != parentClass);

    if (superClass == nil)
    {
      continue;
    }

    [result addObject:classes[i]];
  }

  free(classes);

  return result;
}



+(void)addSelector:(Class)class withOldSel:(SEL)oldSel withNewSel:(SEL)newSel{
    
    Method origMethod = class_getClassMethod(class, oldSel);
    Method altMethod = class_getClassMethod(class, newSel);
    
    if (!origMethod || !altMethod) {
        return;
    }
    Class metaClass = object_getClass(class);
    BOOL didAddMethod = class_addMethod(metaClass,
                                        oldSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(metaClass,
                            newSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
}

+(void)addInstanceFunc:(Class)class fakeClass:(Class)fakeClass withOldSel:(SEL)oldSel withNewSel:(SEL)newSel{
    
    Method origMethod = class_getInstanceMethod(class, oldSel);
    Method altMethod = class_getInstanceMethod(fakeClass, newSel);
    if (!origMethod || !altMethod) {
        return;
    }
    Class metaClass = class;
    BOOL didAddMethod = class_addMethod(metaClass,
                                        oldSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    
    if (didAddMethod) {
        class_replaceMethod(metaClass,
                            newSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }
}



@end

@implementation XToolVC
// 获取当前控制器
+ (UIViewController*)getCurrentViewController {
   UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
   while (1) {
       if ([vc isKindOfClass:[UITabBarController class]]) {
           vc = ((UITabBarController*)vc).selectedViewController;
       }
       if ([vc isKindOfClass:[UINavigationController class]]) {
           vc = ((UINavigationController*)vc).visibleViewController;
       }
       if (vc.presentedViewController) {
           vc = vc.presentedViewController;
       } else {
           break;
       }
   }
   return vc;
}

@end

@implementation XToolStringConverter :NSObject
/// uuid
+ (NSString *)uuidString{
   CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
   CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
   NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
   CFRelease(uuid_ref);
   CFRelease(uuid_string_ref);
   return [uuid lowercaseString];
}

/// 随机数
+ (NSString *)randomString:(NSInteger)number {
    NSString *ramdom;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i ; i ++) {
        int a = (arc4random() % 122);
        if (a > 96) {
            char c = (char)a;
            [array addObject:[NSString stringWithFormat:@"%c",c]];
            if (array.count == number) {
                break;
            }
        } else continue;
    }
    ramdom = [array componentsJoinedByString:@""];
    return ramdom;
}

@end

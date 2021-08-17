#import "XTool.h"
#import "micros.h"
#import <objc/runtime.h>

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

    
#pragma mark - 压缩图片
// 这个方法性能如屎.
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
        NSLog(@"预想:%f ,压缩前大小: %f, 压缩后大小: %u",size, preCompressSize,data.length/1024);
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
    NSLog(@"预想:%f ,压缩前大小: %f, 压缩后大小: %u",size, preCompressSize,data.length/1024);
    perfEnd(img)
    return data;
}


+(NSData *)thumbnail_64kbData:(NSString *)imgurl {
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
@end


@implementation  XToolDataConverter

//字典转json格式字符串:
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
        NSString* sub3=[ [raw substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
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

@end

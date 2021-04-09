//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "NativeContext.h"
#import "iSecurify.h"
 
@interface EntryViewController () <iSecurify>
@property(nonatomic, strong) id<iSecurify> securify;
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

// 2. 模仿点击某个按钮，判断模块是否可用通过
- (void)pushTestModule{
    BOOL isAvailable = [self.securify judgeModuleIsAvailableWithModuleName:@"com.zkty.jsi.direct"];
    NSLog(@"%@", isAvailable ? @"YES" : @"NO");
    NSLog(@"你调用的模块全都好使, 好屌");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 模仿讲microapp存入本地
    NSString *str = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"microapp.json"];
    NSString *txtString = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    self.securify = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iSecurify)];
    [self.securify saveMicroAppJsonWithJson:[self dictionaryWithJsonString:txtString]];
}

#pragma mark - < json->dic / dic->json >
/**
 *  JSON字符串转NSDictionary
 *  @param jsonString JSON字符串
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
/**
 *  字典转JSON字符串
 *  @param dic 字典
 *  @return JSON字符串
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end

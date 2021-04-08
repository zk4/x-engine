//
//  OneViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "OneViewController.h"
#import "JumpViewController.h"
#import "NativeContext.h"
#import "iDirectManager.h"
#import "iSecurify.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块1";
    [self setupView];
//    [self didClickBtn];
    
    // 模仿存入microapp.json
    NSString *str = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"microapp.json"];
    NSString *txtString = [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    id<iSecurify> securify = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iSecurify)];
    [securify saveMicroAppJsonWithJson:[self dictionaryWithJsonString:txtString]];
}

- (void)setupView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    btn.backgroundColor = [UIColor systemPinkColor];
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didClickBtn {
//    [self.navigationController pushViewController:[[JumpViewController alloc ] init] animated:YES];
    id<iDirectManager> director = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];

    [director push:@"microapp" host:@"com.gm.microapp.mine" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
//    [director push:@"http" host:@"www.baidu.com" pathname:@"/" query:nil params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@"/" query:nil
//      [director push:@"omp" host:@"192.168.1.15:8082" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@YES}];
//    [director push:@"omp" host:@"10.2.128.89:8080" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
//    [director push:@"omp" host:@"10.2.128.73:8080" pathname:@"" fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];
    
//    [director push:@"omp" host:@"192.168.1.15:9111" pathname:@"/" query:nil params:@{@"hideNavbar":@NO}];
    
//    [director push:@"omp" host:@"10.2.128.80:8080" pathname:@""  fragment:@"/" query:nil  params:@{@"hideNavbar":@TRUE}];


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

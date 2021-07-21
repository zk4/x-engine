//
//  ThreeViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "ThreeViewController.h"
#import "RecyleWebViewController.h"
#import "MicroAppLoader.h"
#import "XENativeContext.h"
@interface ThreeViewController ()
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模块3";
    [self readH5];
}

- (void)readH5 {
    NSMutableDictionary *dict = [self getFilePathWithIndex:0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSMutableString *microappid = [NSMutableString string];
    if ([mgr fileExistsAtPath:dict[@"filePath"]]) {
        NSString *finalPath = [NSString stringWithFormat:@"file://%@/index.html", dict[@"filePath"]];
        [microappid appendString:finalPath];
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalPath host:dict[@"name"] pathname:@"" fragment:@"" withHiddenNavBar:YES onTab:YES];
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        vc.view.frame = self.view.frame;
    } else {
        [microappid appendString:@"com.gm.microapp.home"];
        NSString *protocol= @"file:";
        NSString *pathname = @"";
        NSString *fragment = @"";
        NSString *host = [[MicroAppLoader sharedInstance] getMicroAppHost:microappid withVersion:0];
        NSString *url = [NSString stringWithFormat:@"%@//%@",protocol,host];
        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:url host:host pathname:pathname fragment:fragment withHiddenNavBar:YES onTab:YES];
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        vc.view.frame = self.view.frame;
    }
}

// 获取本地地址
- (NSMutableDictionary *)getFilePathWithIndex:(int)index {
    NSDictionary *dict =[self getLocalMicroappInfo][index];
    NSString *name = dict[@"name"];
    NSString *version = [NSString stringWithFormat:@"%@", dict[@"version"]];
    NSString *packageName = [NSString stringWithFormat:@"%@.%@", name,version];
    NSString *documentPath= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentPath, packageName];
    
    NSMutableDictionary *localDict = [NSMutableDictionary dictionary];
    localDict[@"name"] = name;
    localDict[@"filePath"] = filePath;
    return localDict;
}

// 获取本地microapp信息
- (NSArray *)getLocalMicroappInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"microapp" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *array = dict[@"packagesInfo"];
    return array;
}
@end

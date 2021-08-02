//
//  ThreeViewController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "ThreeViewController.h"
#import "iOffline.h"
#import <iDirectManager.h>
#import <XENativeContext.h>


@interface ThreeViewController ()
@property (nonatomic, strong) id<iOffline>offline;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    id<iOffline>offline = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iOffline)];
//
//    NSString *path = [offline getPackageWithPackageName:@"com.gm.microapp.mine"];
//
//    NSString *packageURI = [NSString stringWithFormat:@"microapp://%@/index.html", path];
    
    [XENP(iDirectManager) addToTab:self uri:@"microapp://com.gm.microapp.mine" params:@{@"hideNavbar":@TRUE}];
}
@end

















//- (void)readH5 {
//    NSMutableDictionary *dict = [_offline getFilePathWithIndex:2];
//    NSMutableString *microappid = [NSMutableString string];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:dict[@"filePath"]]) {
//        NSString *finalPath = [NSString stringWithFormat:@"file://%@/index.html", dict[@"filePath"]];
//        [microappid appendString:finalPath];
//        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:finalPath host:dict[@"name"] pathname:@"" fragment:@"" withHiddenNavBar:YES onTab:YES];
//        [self addChildViewController:vc];
//        [self.view addSubview:vc.view];
//        vc.view.frame = self.view.frame;
//    } else {
//        [microappid appendString:@"com.gm.microapp.mine"];
//        NSString *protocol= @"file:";
//        NSString *pathname = @"";
//        NSString *fragment = @"";
//        NSString *host = [[MicroAppLoader sharedInstance] getMicroAppHost:microappid withVersion:0];
//        NSString *url = [NSString stringWithFormat:@"%@//%@",protocol,host];
//        RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithUrl:url host:host pathname:pathname fragment:fragment withHiddenNavBar:YES onTab:YES];
//        [self addChildViewController:vc];
//        [self.view addSubview:vc.view];
//        vc.view.frame = self.view.frame;
//    }
//}

//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

#import "XERouterManager.h"

#import <x-engine-module-dcloud/__xengine__module_dcloud.h>
#import <x-engine-module-dcloud/XEUniCheckUtil.h>
#import <XEngineContext.h>

#import "XERouterManager.h"
@interface EntryViewController ()

@end

@implementation EntryViewController
 
-(void) pushTestModule{
//    [XERouterManager routerToTarget:@"uniapp" withUri:@"__UNI__807D551.wgt" withPath:@"/" withArgs:nil withVersion:1];
    NSString* uri = @"__UNI__807D551";
    if([XEUniCheckUtil checkUniFile:uri]){
                 NSString *dcloudname = NSStringFromClass(__xengine__module_dcloud.class);
                 __xengine__module_dcloud *dcloud = [[XEngineContext sharedInstance] getModuleByName:dcloudname];
                 UniMPDTO* d = [UniMPDTO new];
                 d.appId = uri;
                 d.redirectPath = @"/";
                 d.arguments = nil;
                 [dcloud _openUniMPWithArg:d complete:nil];
             }
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"to" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake((self.view.bounds.size.width - 100) * 0.5,
                           (self.view.bounds.size.height - 50) * 0.5,
                           100,
                           50);
    [self.view addSubview:btn];
    [self pushTestModule];
}

- (void)action {
    [self pushTestModule];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
@end

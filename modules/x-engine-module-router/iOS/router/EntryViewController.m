//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
//#import <MircroAppController.h>
#import <UIViewController+.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "ZKPushAnimation.h"
#import "XERouterManager.h"

@interface EntryViewController ()

@end

@implementation EntryViewController
 
-(void) pushTestModule{
//   MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:@"http://0.0.0.0:8081"];
//   [self pushViewController:webLaderVC];
    [XERouterManager routerToTarget:@"microapp" withUri:@"com.times.microapp.AppcMsg" withPath:@"/" withArgs:nil withVersion:1];
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

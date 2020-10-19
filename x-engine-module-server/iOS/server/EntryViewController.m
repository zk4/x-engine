//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import <XEngineContext.h>
#import <MircroAppController.h>
#import <UIViewController+.h>
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}


-(void) pushTestModule{
    // 启动 h5 服务器, npm run dev
    // 将下面的 ip 换成你的电脑 ip 即可实时调试
    RecyleWebViewController *webLaderVC = [[RecyleWebViewController alloc] initWithUrl:@"http://0.0.0.0:8080"];
     [self pushViewController:webLaderVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import <MircroAppController.h>
#import <UIViewController+.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "ZKPushAnimation.h"

@interface EntryViewController ()

@end

@implementation EntryViewController



- (NSString *)getIPAddress {

    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }

            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;

}
-(void) pushTestModule{
    // 启动 h5 服务器, npm run dev
    // 将下面的 ip 换成你的电脑 ip 即可实时调试
//   NSString* url = [NSString stringWithFormat:@"http://0.0.0.0:8000",[self getIPAddress]];
   MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:@"http://192.168.44.55:8080"];
   [self pushViewController:webLaderVC];
    
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

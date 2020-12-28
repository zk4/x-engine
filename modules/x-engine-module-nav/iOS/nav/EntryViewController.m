//
//  EntryViewController.m


#import "EntryViewController.h"
#import "RecyleWebViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "XEOneWebViewControllerManage.h"

@interface EntryViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn2;
@end

@implementation EntryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _actionBtn.layer.masksToBounds = YES;
    _actionBtn.layer.cornerRadius = 10.0;
    
    _actionBtn.layer.masksToBounds = YES;
    _actionBtn.layer.cornerRadius = 10.0;
    
    self.navigationController.navigationBar.translucent = NO;
//  [[XEOneWebViewControllerManage sharedInstance] setMainUrl:@"http://0.0.0.0:8080"];
}

- (IBAction)Action:(id)sender {
    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://192.168.1.106:8080"];
}
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
- (IBAction)Action2:(id)sender {
    
//    [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithAppid:@"com.zkty.module.navpush" withVersion:0 withPath:@"/" withParams:nil forceCreate:TRUE];
//        [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithAppid:@"dist" withVersion:0 withPath:@"/" withParams:nil forceCreate:TRUE];

    [[XEOneWebViewControllerManage sharedInstance] pushWebViewControllerWithHttpRouteUrl:@"http://192.168.1.106:8080"];

}

@end

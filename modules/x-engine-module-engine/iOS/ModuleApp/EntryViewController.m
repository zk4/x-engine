
#import "EntryViewController.h"
#import <MircroAppController.h>
#import "UIViewController+.h"
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
//          MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.moduledemo"];
        
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithUrl:@"http://0.0.0.0:8080"];

    [self pushViewController:webLaderVC ];
}

 
@end

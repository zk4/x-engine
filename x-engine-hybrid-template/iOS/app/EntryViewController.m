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
- (IBAction)Action0:(id)sender {
   MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.demo0"   ];
       [self pushViewController:webLaderVC];
}

- (IBAction)Action1:(id)sender {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.demo1"  ];
       [self pushViewController:webLaderVC];
}
- (IBAction)Action2:(id)sender {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.demo2"   ];
       [self pushViewController:webLaderVC];
}
- (IBAction)Action3:(id)sender {
    MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:@"com.zkty.microapp.demo3"  ];
       [self pushViewController:webLaderVC];
}
- (IBAction)module_nav:(id)sender {
    [self pushTestModule:@"com.zkty.module.nav"];
}
- (IBAction)module_nav_push:(id)sender {
    [self pushTestModule:@"com.zkty.module.navpush"];
}
- (IBAction)module_localstorage:(id)sender {
      [self pushTestModule:@"com.zkty.module.localstorage"];
}
- (IBAction)module_pulldown:(id)sender {
        [self pushTestModule:@"com.zkty.module.pulldown"];
}
- (IBAction)module_camera:(id)sender {
    [self pushTestModule:@"com.zkty.module.camera"];

}

-(void) pushTestModule:(NSString*) appid {
MircroAppController *webLaderVC = [[MircroAppController alloc] initWithMicroAppId:appid   ];
       [self pushViewController:webLaderVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self pushTestModule];
}

@end

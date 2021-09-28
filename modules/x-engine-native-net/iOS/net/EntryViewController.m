//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iDev.h>
#import "iToast.h"
#import "OKHttp.h"


@interface HTTpSerializeInterceptor:NSObject <iFilter>
@end

@implementation HTTpSerializeInterceptor
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(nonnull FilterChain *)chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;
    [XENP(iToast) toast:@"before request"];
    response([@"hello,modified" dataUsingEncoding:NSUTF8StringEncoding],nil,nil);
    return;
    [chain doFilter:session request:request response:response];

}
@end


@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id ok = [[OKHttp new] build:({
        NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        req;
    })];
    [ok addFilter:[HTTpSerializeInterceptor new]];
   
    
    [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            [XENP(iToast) toast:[error localizedDescription]];
        }else{
            [XENP(iToast) toast:@"success"];
            NSLog(@"%@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
    id<iDev> dev = XENP(iDev);
    
    [dev log:@"world"];
    // 切换 Build Configuration　里的　Debug 　与 Release
    [dev xlog:@"world"];
}

@end

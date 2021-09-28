//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iDev.h>
#import "iToast.h"
#import "iNet.h"
@interface ConfigFilter:NSObject <iFilter>
@end

@implementation ConfigFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;
    [chain doFilter:session request:request response:response];
}
@end


@interface LoggingFilter:NSObject <iFilter>
@end

@implementation LoggingFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;

    NSLog(@"%@", @"request start");
    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
        response(data,res,error);
        NSLog(@"%@", @"response end");
    };

    [chain doFilter:session request:request response:newResponse];
}
@end

@interface LoggingFilter2:NSObject <iFilter>
@end

@implementation LoggingFilter2
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    
    NSLog(@"%@", @"request start 2");
    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
        response(data,res,error);
        NSLog(@"%@", @"response end 2");
    };

    [chain doFilter:session request:request response:newResponse];
}
@end


@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id ok = [[XENP(iNetManager) one] build:({
        NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        req;
    })];
    [ok addFilter:[ConfigFilter new]];
    [ok addFilter:[LoggingFilter new]];
    [ok addFilter:[LoggingFilter2 new]];

    
    [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            [XENP(iToast) toast:[error localizedDescription]];
        }else{
            NSLog(@"%@", @"success");

//            NSLog(@"%@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
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

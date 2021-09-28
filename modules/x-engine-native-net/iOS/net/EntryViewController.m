//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iNet.h"

#import "MergeRequestFilter.h"

@interface ConfigFilter:NSObject <iFilter>
@end

@implementation ConfigFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;
    [chain doFilter:session request:request response:response];
}
@end




@interface AddTokenFilter:NSObject <iFilter>
@end

@implementation AddTokenFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    NSMutableDictionary* newHeaders= [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    newHeaders[@"Bearer"]=@"TOKEN";
    request.allHTTPHeaderFields=newHeaders;
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
        
        NSString *str  = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        NSString* newStr= [NSString stringWithFormat:@"%@%@",str,@"back 1"];
        
        NSData* newData =  [newStr dataUsingEncoding:NSUTF8StringEncoding];
        response(newData,res,error);
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
        NSData* newData =  [@"back 2" dataUsingEncoding:NSUTF8StringEncoding];
        response(newData,res,error);
        
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

    id config = [ConfigFilter new];
    id merged = [MergeRequestFilter new];
    id token  = [AddTokenFilter new];
    
    for (int i =0; i<1000; i++) {
        id ok = [[XENP(iNetManager) one] build:({
            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
            req;
        })];
        [ok addFilter:config];
        [ok addFilter:merged];
        [ok addFilter:token];
        
        [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                NSLog(@"error");
            }else{
                NSLog(@"%@", @"success");
                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

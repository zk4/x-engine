//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iNet.h"
#import "iToast.h"

#import "GlobalMergeRequestFilter.h"
#import "GlobalConfigFilter.h"
#import "GlobalServerErrorWithoutCallbackFilter.h"
#import "GlobalJsonFilter.h"

#import "JSONModel.h"
#import "XTool.h"
#import "NSMutableURLRequest+Filter.h"

 

//@interface AddTokenFilter:NSObject <iFilter>
//@end
//
//@implementation AddTokenFilter
//- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
//    NSMutableDictionary* newHeaders= [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
//    newHeaders[@"Bearer"]=@"TOKEN";
//    request.allHTTPHeaderFields=newHeaders;
//    [chain doFilter:session request:request response:response];
//}
//@end
//
//
//
//@interface LoggingFilter:NSObject <iFilter>
//@end
//
//@implementation LoggingFilter
//- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
//    session.configuration.HTTPMaximumConnectionsPerHost = 0;
//
//    NSLog(@"%@", @"request start");
//    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
//
//        NSString *str  = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
//        NSString* newStr= [NSString stringWithFormat:@"%@%@",str,@"back 1"];
//
//        NSData* newData =  [newStr dataUsingEncoding:NSUTF8StringEncoding];
//        response(newData,res,error);
//    };
//
//    [chain doFilter:session request:request response:newResponse];
//}
//@end
//
//@interface LoggingFilter2:NSObject <iFilter>
//@end
//
//@implementation LoggingFilter2
//- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
//
//    NSLog(@"%@", @"request start 2");
//    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
//        NSData* newData =  [@"back 2" dataUsingEncoding:NSUTF8StringEncoding];
//        response(newData,res,error);
//
//    };
//
//    [chain doFilter:session request:request response:newResponse];
//}
//@end


@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (void)test1 {
    for (int i =0; i<1000; i++) {
        
        id req = [NSMutableURLRequest new];
        [req addFilter:[GlobalConfigFilter sharedInstance]];
        [req addFilter:[GlobalServerErrorWithoutCallbackFilter sharedInstance]];
        [req addFilter:[GlobalMergeRequestFilter sharedInstance]];
        [req addFilter:[GlobalJsonFilter sharedInstance]];
        
        [req setURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
        
        [req send:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@", data);
          
         }];
    }
}

- (void)test2 {
    for (int i =0; i<1000; i++) {
        id ok = [[XENP(iNetManager) one] build:({
            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
            req;
        })];
        [ok addFilter:[GlobalConfigFilter sharedInstance]];
        [ok addFilter:[GlobalServerErrorWithoutCallbackFilter sharedInstance]];
        [ok addFilter:[GlobalMergeRequestFilter sharedInstance]];
        [ok addFilter:[GlobalJsonFilter sharedInstance]];
        
        
        [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                NSLog(@"error");
            }else{
                NSLog(@"%@", data);
                
                //                        NSString* str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                //                        NSDictionary* model  = [XToolDataConverter dictionaryWithJsonString:str];
                
                //                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
            }
        }];
    }
}

-(void) pushTestModule{
    [self test1];
     
    
//    [self test2];

        /////////////////////////////////////////////////////////////////////// the second writing style

//                NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
//
//        id req = [NSMutableURLRequest new];
//        [req setURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
//        [req addFilter:config];
//        [req addFilter:merged];
//        [req addFilter:token];
//        [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            // 仅当服务器返回时，才会进到这
//            if(error){
//                NSLog(@"error");
//            }else{
//                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
//            }
//        }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

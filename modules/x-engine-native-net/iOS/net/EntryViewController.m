//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iNet.h"

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

-(void) pushTestModule{
    
    id req = [NSMutableURLRequest new];
    [req addFilter:[GlobalConfigFilter new]];
    [req addFilter:[GlobalServerErrorWithoutCallbackFilter new]];
    [req addFilter:[GlobalJsonFilter new]];
    [req setURL:[NSURL URLWithString:@"https://httpbin.org/get"]];

    [req send:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", data);
    }];
    
    
//    [req send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        // 这里不会有回调，错误由全局 GlobalServerErrorWithoutCallbackFilter 拦截处理了。
//        NSAssert(FALSE, @"should not  called");
//    }];
//
//    id config = [GlobalConfigFilter new];
//    id merged = [GlobalMergeRequestFilter new];
//    id token  = [AddTokenFilter new];
    
//    for (int i =0; i<10; i++) {
////        id ok = [[XENP(iNetManager) one] build:({
////            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
////            req;
////        })];
////        [ok addFilter:config];
////        [ok addFilter:merged];
////        [ok addFilter:token];
////
////
////        [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
////            if(error){
////                NSLog(@"error");
////            }else{
////                //                        NSString* str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
////                //                        NSDictionary* model  = [XToolDataConverter dictionaryWithJsonString:str];
////
////                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
////            }
////        }];
//
//
//        /////////////////////////////////////////////////////////////////////// the second writing style
//
////                NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
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
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

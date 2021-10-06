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
#import "GlobalStatusCodeNot2xxFilter.h"
#import "GlobalJsonFilter.h"
#import "NSMutableURLRequest+Filter.h"
#import "GlobalNoResponseFilter.h"

#import "JSONModel.h"
#import "XTool.h"

#import "TodoApi.h"
#import "PostApi.h"
#import "x_api_Simple.h"
#import "x_api_gm_general_appVersion_checkUpdate.h"



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
@interface LoggingFilter0:NSObject <iFilter>
@end

@implementation LoggingFilter0
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;

    NSLog(@"%@", @"logging 1 start");
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSLog(@"logging 1 end");
        response(data,res,error);

    }];

}
@end
//
@interface LoggingFilter2:NSObject <iFilter>
@end

@implementation LoggingFilter2
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {

    NSLog(@"%@", @"logging 2 start");
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSLog(@"logging 2 end");
        response(data,res,error);

    }];
}
@end

@interface LoggingFilter3:NSObject <iFilter>
@end

@implementation LoggingFilter3
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {

    NSLog(@"%@", @"logging 3 start");
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSLog(@"logging 3 end");
        response(data,res,error);

    }];
}
@end

@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (void)test0 {
    
    [KOBaseApi configSchemaHost:@"http://10.115.91.71:32563/bff-m"];
    [KOBaseApi configGlobalFiltersWithNetwork:^(NSMutableURLRequest * _Nonnull request) {
        [request addFilter:[GlobalConfigFilter sharedInstance]];
        [request addFilter:[GlobalStatusCodeNot2xxFilter sharedInstance]];
        [request addFilter:[LoggingFilter0 new]];
        [request addFilter:[LoggingFilter2 new]];
        [request addFilter:[LoggingFilter3 new]];
        [request addFilter:[GlobalNoResponseFilter sharedInstance]];
        [request addFilter:[GlobalMergeRequestFilter sharedInstance]];
        [request addFilter:[GlobalJsonFilter sharedInstance]];

    }];

    x_api_gm_general_appVersion_checkUpdate_Req* req= [x_api_gm_general_appVersion_checkUpdate_Req new];
    req.os=@"ios";
    req.platform=@"ios";
    req.versionCode=0;
    req.versionName=@"";
    [[[x_api_gm_general_appVersion_checkUpdate new] promise:req] then:^id _Nullable(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable value) {
        NSLog(@"%@",value);
        return nil;
    }];
    
//    SimpleReq* arg = [SimpleReq new];
//    arg.userId =@"zk";
//    [[[gen_SimpleApi new] promise:arg] then:^id _Nullable(SimpleRes * _Nullable value) {
//        NSLog(@"data returned");
//        return nil;
//    }];
//    for (int i =1; i<2; i++) {
//        {
//            id sapi= [gen_SimpleApi new];
//            SimpleReq* reqa = [SimpleReq new];
//            reqa.userId =@"zk";
//            [[sapi promise:reqa] then:^id _Nullable(SimpleRes * _Nullable value) {
//                NSLog(@"%@",value);
//                return nil;
//            }];
//
//        }
//
//        PostApi* api = [PostApi  new];
//        PostReq* postReq = [PostReq new];
//
//        postReq.title=@"hello,world";
//        postReq.moreMsg =@"more msg";
//        postReq.hello.world.inner =@"inner is here";
//
//
//        //        [api request:^(PostRes * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
//        //            NSLog(@"%@",data.toDictionary);
//        //        }];
//        [[[[[[api promise: postReq] then:^id _Nullable(PostRes * _Nullable value) {
//            NSLog(@"%@",value.toDictionary);
//            return @"hello";
//        }]
//            then:^id _Nullable(id  _Nullable value) {
//            NSLog(@"%@",value);
//            return @"world";
//        }]
//           then:^id _Nullable(id  _Nullable value) {
//            NSLog(@"%@",value);
//            return @"end";
//        }]
//          then:^id _Nullable(id  _Nullable value) {
//            return [NSError errorWithDomain:FBLPromiseErrorDomain code:42 userInfo:nil];
//            return nil;
//        }]
//         catch:^(NSError * _Nonnull error) {
//            NSLog(@"%ld",error.code);
//        }] ;
//    }
}
//
//- (void)test1 {
//    for (int i =1; i<100; i++) {
//        TodoApi* api = [TodoApi new];
//        api.tid=i;
//        [api request:^(Hello * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
//            NSLog(@"%@",data);
//            [XENP(iToast) toast:[data toJSONString]];
//        }];
//    }
//}

- (void)test2 {
    for (int i =0; i<1000; i++) {
        id ok = [[XENP(iNetManager) one] build:({
            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
            req;
        })];
        [ok addFilter:[GlobalConfigFilter sharedInstance]];
        [ok addFilter:[GlobalStatusCodeNot2xxFilter sharedInstance]];
        [ok addFilter:[GlobalMergeRequestFilter sharedInstance]];
        [ok addFilter:[GlobalJsonFilter sharedInstance]];
        [ok send:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            
        }];
        
        //
        //        [ok send:^(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //            if(error){
        //                NSLog(@"error");
        //            }else{
        //                NSLog(@"%@", data);
        //
        //                //                        NSString* str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
        //                //                        NSDictionary* model  = [XToolDataConverter dictionaryWithJsonString:str];
        //
        //                //                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
        //            }
        //        }];
    }
}

-(void) pushTestModule{
    [self test0];
    //    [self test1];
    
    
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

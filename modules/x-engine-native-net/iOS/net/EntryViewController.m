//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iKONet.h"
#import "iToast.h"

#import "GlobalReqResMergeRequestFilter.h"
#import "GlobalReqConfigFilter.h"
#import "GlobalResStatusCodeNot2xxFilter.h"
#import "GlobalResConvert2DictFilter.h"
#import "NSMutableURLRequest+Filter.h"
#import "GlobalResNoResponseFilter.h"
#import "KOHttp.h"

#import "JSONModel.h"
#import "XTool.h"

#import "TodoApi.h"
#import "PostApi.h"

#import "x_api_gm_general_appVersion_checkUpdate.h"
#import "x_api_gm_general_login.h"



//@interface AddTokenFilter:NSObject <iKOFilter>
//@end
//
//@implementation AddTokenFilter
//- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
//    NSMutableDictionary* newHeaders= [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
//    newHeaders[@"Bearer"]=@"TOKEN";
//    request.allHTTPHeaderFields=newHeaders;
//    [chain doFilter:session request:request response:response];
//}
//@end
//
//
//
@interface LoggingFilter0:NSObject <iKOFilter>
@end

@implementation LoggingFilter0
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;

    NSLog(@"%@", @"logging 1 start");
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSLog(@"logging 1 end");
        response(data,res,error);

    }];

}
- (nonnull NSString *)name {
    return @"自定义日志 filter 1";
}

@end
//
@interface LoggingFilter2:NSObject <iKOFilter>
@end

@implementation LoggingFilter2
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {

    NSLog(@"%@", @"logging 2 start");
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        NSLog(@"logging 2 end");
        response(data,res,error);

    }];
}

- (nonnull NSString *)name {
    return @"自定义日志 filter 2";
}

@end

@interface BusinessFilter:NSObject <iKOFilter>
@end

@implementation BusinessFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull KOResponse)response chain:(id<iKOFilterChain>) chain {
    
    [chain doFilter:session request:request response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
        if(data && data[@"data"]){
            response(data[@"data"],res,error);
        }else{
            NSString* msg = [NSString stringWithFormat:@"提取业务字段 data 失败, response: %@", data];
            [XENP(iToast)  toast:msg];
            return;
        }
    }];
}
- (nonnull NSString *)name {
    return @"提取 data 数据 filter";
}

@end

@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (void)test0 {
    
    x_api_gm_general_login_Req *req = [x_api_gm_general_login_Req new];
        req.username = @"zhangguoqin-xphl@gome.inc";
        req.password = @"97654-qcwgz";
        req.ldapId = 1;
        
    id api = [x_api_gm_general_login new];
    [api setLocalUrlPrefix:@"http://10.115.91.95:9530/bff-b"];
    [[api promise:req] then:^id _Nullable(x_api_gm_general_login_Res * _Nullable value) {
        NSLog(@"%@", value);
        return nil;
    }];

    for (int i =1; i<20; i++) {
//        x_api_gm_general_appVersion_checkUpdate_Req* req= [x_api_gm_general_appVersion_checkUpdate_Req new];

/*
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setValue:@"IOS" forKey:@"os"];
 [dic setValue:@"App-C" forKey:@"platform"];
 NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
 NSString *version = [NSString stringWithFormat:@"%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
 [dic setValue:version forKey:@"versionName"];
 */
//        req.os=@"IOS";
//        req.platform=@"App-C";
//        req.versionName=@"1.0.0";
//        id api = [x_api_gm_general_appVersion_checkUpdate new];
//        [api setLocalUrlPrefix:@"https://api.lohashow.com/bff-c"];
//        [[api promise:req] then:^id _Nullable(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable value) {
//            NSLog(@"%@",value);
//            return nil;
//        }];
//        [api setDtoReq:req];
//        [api request:^(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
//            NSLog(@"%@",data);
//        }];
    }
    
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
        id ok = [XENP(iKONetManager) one];
        [ok addFilter:[GlobalReqConfigFilter sharedInstance]];
        [ok addFilter:[GlobalResStatusCodeNot2xxFilter sharedInstance]];
        [ok addFilter:[GlobalReqResMergeRequestFilter sharedInstance]];
        [ok addFilter:[GlobalResConvert2DictFilter sharedInstance]];
        NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
        [ok send:req response:^(id  _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            NSLog(@"%@",data);
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
    
    
//        [self test2];
    
    /////////////////////////////////////////////////////////////////////// the second writing style
    
//            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://httpbin.org/get"]];
    
      
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [KOHttp ko_configGlobalUrlPrefix:@"https://api.lohashow.com/bff-c"];
    [KOHttp ko_configPipelineByName:@"DEFAULT" pipeline:({
        id pipeline =  [NSMutableArray new];
        [pipeline addObject:[GlobalReqConfigFilter sharedInstance]];
        [pipeline addObject:[LoggingFilter0 new]];
        [pipeline addObject:[BusinessFilter new]];
        [pipeline addObject:[GlobalReqResMergeRequestFilter sharedInstance]];
        [pipeline addObject:[GlobalResConvert2DictFilter sharedInstance]];
        [pipeline addObject:[GlobalResStatusCodeNot2xxFilter sharedInstance]];
        [pipeline addObject:[GlobalResNoResponseFilter sharedInstance]];

        pipeline;
    })];
    
    
    [KOHttp ko_configPipelineByName:@"SIMPLE" pipeline:({
        id pipeline =  [NSMutableArray new];
        [pipeline addObject:[GlobalReqConfigFilter sharedInstance]];
        [pipeline addObject:[GlobalResNoResponseFilter sharedInstance]];

        [pipeline addObject:[LoggingFilter0 new]];
        [pipeline addObject:[GlobalReqResMergeRequestFilter sharedInstance]];
        [pipeline addObject:[GlobalResConvert2DictFilter sharedInstance]];
        [pipeline addObject:[GlobalResStatusCodeNot2xxFilter sharedInstance]];
        pipeline;
    })];
    
    [self pushTestModule];
}

@end

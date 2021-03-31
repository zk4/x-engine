//
//  JSIVueRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSIOldRouterModule.h"
#import "JSIContext.h"
#import "iDirectManager.h"
#import "NativeContext.h"
#import "NSURL+QueryDictionary.h"

@interface JSIOldRouterModule ()
@property (nonatomic, strong)   id<iDirectManager>  directors;
@end
@implementation JSIOldRouterModule
JSI_MODULE(JSIOldRouterModule)

- (NSString*) moduleId{
    return @"com.zkty.module.router";
}

-(void)afterAllJSIModuleInited {
    self.directors = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
}


static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
static NSString *const kSlash               = @"/";

+ (NSDictionary*) convertRouter2JSIModel:(NSDictionary*) dict{
    NSMutableDictionary* ret= [NSMutableDictionary new];
    ret[@"scheme"] =dict[@"type"];
    
    NSString* host= dict[@"uri"];
    
    if([dict[@"type"] isEqualToString:@"microapp"]){
        // 要注意，本地 file 协议从标准上， host 应为 ""，
        // 但是 pathname 需要做路由路径，将 index.html 文件位置指定为 host
        // 将 microapp id 做成虚拟 host
        host=[NSString stringWithFormat:@"http://%@",host];
    }
    
    NSString* raw_url = [NSString stringWithFormat:@"%@%@",host,    dict[@"path"]];
    
    // URL encode
    NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlString_encode =[raw_url stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    NSURL * url = [NSURL URLWithString:urlString_encode];
    
    ret[@"host"]=url.host;
    
    NSArray* pathArray = [dict[@"path"] componentsSeparatedByString:kQueryBegin];
    ret[@"pathname"]=pathArray.count>0?pathArray[0]:kSlash;
    
    ret[@"query"]= url.uq_queryDictionary;
    
    
    if([dict[@"hideNavbar"] boolValue]){
        ret[@"params"] = @{@"hideNavbar":@TRUE};
    }
    
    return ret;
}

- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    NSDictionary* directDTO = [JSIOldRouterModule convertRouter2JSIModel:dict];
    [self.directors push:directDTO[@"scheme"] host:directDTO[@"host"] pathname:directDTO[@"pathname"] query:directDTO[@"query"] params:directDTO[@"params"]];
}
@end

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

+ (NSString*)SPAUrl2StandardUrl:(NSString*)raw {
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< raw.length;i++){
        char cc= [raw characterAtIndex:i];

        if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
        else if(cc == '?' && questionMark == -1){
            questionMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* sub1= [raw substringToIndex:hashtagMark];
        NSString* sub2= [raw substringWithRange:NSMakeRange(hashtagMark, questionMark-hashtagMark)];
        NSString* sub3=[ [raw substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
}
// 区分 vue 的 url
// 与标准的 rfc url
+ (NSDictionary*) convertRouter2JSIModel:(NSDictionary*) dict{
    NSMutableDictionary* ret= [NSMutableDictionary new];
    ret[@"scheme"] =dict[@"type"];
    
    NSString* host= dict[@"uri"];
    NSString* url_need_check = @"";
    
    if([dict[@"type"] isEqualToString:@"microapp"]){
        // 一定是非标 url
        // microapp id，应该组装成 http://, 以供 NSURL 标准化
        url_need_check = [NSString stringWithFormat:@"http://%@#%@",host, dict[@"path"]];
    }
    else{
        // 其他的直接拼接
        // 可能是普通 url
        // 也可能是非标 url
        if([host containsString:@"#"])
            url_need_check = [NSString stringWithFormat:@"%@%@",host, dict[@"path"]];
        else
            url_need_check = [NSString stringWithFormat:@"%@#%@",host, dict[@"path"]];

    }
    // 全部转化为标准 url
    NSString* standard_url = [JSIOldRouterModule SPAUrl2StandardUrl:url_need_check];

    NSURL * url = [NSURL URLWithString:standard_url];
 
    if(url.port){
        ret[@"host"]=[NSString stringWithFormat:@"%@:%@" , url.host, url.port];
    }else{
        ret[@"host"]=url.host;
    }
    // https://tools.ietf.org/html/rfc3986#page-22
    if(url.path && url.path.length != 0 )
        ret[@"pathname"]=url.path;
    else
        ret[@"pathname"]=@"";
    
    if(url.fragment)
        ret[@"fragment"]=url.fragment;
    else
        ret[@"fragment"]=@"/";

    ret[@"query"]= url.uq_queryDictionary;

    
    if(dict[@"hideNavbar"]){
        ret[@"params"] = @{@"hideNavbar":dict[@"hideNavbar"]};
    }

    return ret;
}

- (void) openTargetRouter:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {
    NSDictionary* directDTO = [JSIOldRouterModule convertRouter2JSIModel:dict];
    [self.directors push:directDTO[@"scheme"] host:directDTO[@"host"] pathname:directDTO[@"pathname"] fragment:directDTO[@"fragment"] query:directDTO[@"query"] params:directDTO[@"params"]];
}
@end

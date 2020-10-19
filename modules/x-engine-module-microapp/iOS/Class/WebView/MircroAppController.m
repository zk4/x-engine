#import "MircroAppController.h"
#import "MicroAppLoader.h"
#import "Unity.h"

#import "XEOneWebViewControllerManage.h"
/*
┌─────────────────────────────────────────────────────────────────────────────────────────────┐
│                                            href                                             │
├──────────┬──┬─────────────────────┬─────────────────────┬───────────────────────────┬───────┤
│ protocol │  │        auth         │        host         │           path            │ hash  │
│          │  │                     ├──────────────┬──────┼──────────┬────────────────┤       │
│          │  │                     │   hostname   │ port │ pathname │     search     │       │
│          │  │                     │              │      │          ├─┬──────────────┤       │
│          │  │                     │              │      │          │ │    query     │       │
"  https:   //    user   :   pass   @ sub.host.com : 8080   /p/a/t/h  ?  query=string   #hash "
│          │  │          │          │   hostname   │ port │          │                │       │
│          │  │          │          ├──────────────┴──────┤          │                │       │
│ protocol │  │ username │ password │        host         │          │                │       │
├──────────┴──┼──────────┴──────────┼─────────────────────┤          │                │       │
│   origin    │                     │       origin        │ pathname │     search     │ hash  │
├─────────────┴─────────────────────┴─────────────────────┴──────────┴────────────────┴───────┤
│                                            href                                             │
└─────────────────────────────────────────────────────────────────────────────────────────────┘
*/
@interface MircroAppController ()
@property (nonatomic, copy) NSString *microappId;
@property (nonatomic, copy) NSString *version;
@end

@implementation MircroAppController

//static NSString* current_index_path= nil;

//- (NSString *)preLevelPath:(NSString *)preLevelPath {
//    if (preLevelPath && ![preLevelPath isEqualToString:@""]) {
//       return [NSString stringWithFormat:@"#%@",preLevelPath];
//    }
//    return @"";
//}

//- (instancetype)initWithPreLevelPath:(NSString *)preLevelPath {
//
//    self = [super initWithUrl:[current_index_path stringByAppendingString:[self preLevelPath:preLevelPath]]];
//    return self;
//}
 
- (instancetype)initWithUrl:(NSString *) fileUrl{

    [MicroAppLoader sharedInstance].nowMicroAppId = fileUrl;
    
    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:fileUrl]];
//    if (![fileUrl hasPrefix:@"http"]){
//        fileUrl = [current_index_path stringByAppendingString:[self preLevelPath:fileUrl]];
//    } else {
//        current_index_path = fileUrl;
//    }
//    return [self initWithUrl:fileUrl query:nil];
}

//- (instancetype) initWith:(NSString*)scheme host:(NSString*)host port:(NSNumber*)port path:(NSString*)path query:(NSString*)query  fragment:(NSString*) fragment{
//    NSURLComponents* urlc=  [[NSURLComponents alloc] init];
//    urlc.scheme= scheme;
//    urlc.host = host;
//    urlc.port= port;
//    urlc.path= path;
//    urlc.query=query;
//    urlc.fragment=fragment;
//    NSString* finalUrl= [[urlc URL] absoluteString];
//    return [self initWithUrl:finalUrl query:nil];
//    
//}
- (instancetype)initWithUrl:(NSString *)index_url query:(NSString*) query{
    
    NSString *fullpath = nil;
    if (index_url){
        NSRange range = [index_url rangeOfString:@"index.html" options:NSBackwardsSearch];
        if(range.location == NSNotFound){
            if([index_url hasSuffix:@"/"])
                index_url = [NSString stringWithFormat:@"%@index.html",index_url];
            else
                index_url = [NSString stringWithFormat:@"%@/index.html",index_url];
        }
        if (query){
            
            fullpath = [NSString stringWithFormat:@"%@?%@",index_url, query];
        } else {
            fullpath = index_url;
        }
    }
    self = [super initWithUrl:fullpath];
    return self;
}
- (instancetype)initWithMicroAppId:(NSString *)microappId{
    
    assert(microappId != nil);
    [MicroAppLoader sharedInstance].nowMicroAppId = microappId;
    long version;
    NSString* indexfile = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:microappId out_version:&version];
    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:indexfile]];
}
- (instancetype)initWithMicroAppId:(NSString *)microappId route:(NSString*)path
{
    assert(microappId!=nil && path !=nil);
    
    [MicroAppLoader sharedInstance].nowMicroAppId = microappId;
    
    long version;
    NSString *indexfile = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:microappId out_version:&version];
    NSString *fullpath = [NSString stringWithFormat:@"%@%@",indexfile, path];
//    self = [super initWithUrl:fullpath];
//    current_index_path = indexfile;
//    return self;
    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:fullpath]];
}

//-(void)loadFileUrl:(NSString *)url query:(NSString *)query {
//    if([url hasPrefix:@"http"]){
//        if(![url hasSuffix:@"index.html"] && ![url hasSuffix:@"index.html/"]){
//            if([url hasSuffix:@"/"])
//                url = [NSString stringWithFormat:@"%@index.html", url];
//            else
//                url = [NSString stringWithFormat:@"%@/index.html", url];
//        }
//    }
//
//    NSString *fullpath;
//    if (query){
//
//        NSRange range = [url rangeOfString:@"?" options:NSBackwardsSearch];
//        fullpath = [url stringByAppendingFormat:@"%@params=%@", range.location == NSNotFound ? @"?" : @"&", query];
//    } else {
//        fullpath = url;
//    }
//    self.preLevelPath = url;
//    [self loadFileUrl:fullpath];
//}

//-(void)loadFileUrl:(NSString *)url{
//    if ([url hasPrefix:@"http"]){
//        current_index_path = url;
//        [super loadFileUrl:url];
//    } else if (url == nil) {
//        [super loadFileUrl:current_index_path];
//    } else {
//
//        [super loadFileUrl:[current_index_path stringByAppendingString:[self preLevelPath:url]]];
//    }
//}

@end


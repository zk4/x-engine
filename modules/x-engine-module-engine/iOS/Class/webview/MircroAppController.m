#import "MircroAppController.h"
#import "MicroAppLoader.h"
#import "Unity.h"
#import "XEOneWebViewControllerManage.h"
 
@interface MircroAppController ()
@property (nonatomic, copy) NSString *microappId;
@property (nonatomic, copy) NSString *version;
@end

@implementation MircroAppController
 
- (instancetype)initWithUrl:(NSString *) fileUrl{
    [MicroAppLoader sharedInstance].nowMicroAppId = fileUrl;
    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:fileUrl]];
}
 
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

    NSString* indexfile = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:microappId in_version:0];
    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:indexfile]];
}
- (instancetype)initWithMicroAppId:(NSString *)microappId route:(NSString*)path
{
    assert(microappId!=nil && path !=nil);
    
    [MicroAppLoader sharedInstance].nowMicroAppId = microappId;

    NSString *indexfile = [[MicroAppLoader sharedInstance] locateMicroAppByMicroappId:microappId in_version:0];
    NSString *fullpath = [NSString stringWithFormat:@"%@%@",indexfile, path];

    return [[XEOneWebViewControllerManage sharedInstance] getWebViewControllerWithUrl:[[XEOneWebViewControllerManage sharedInstance] setMainUrl:fullpath]];
}
 
@end


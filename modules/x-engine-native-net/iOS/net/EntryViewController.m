//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <x-engine-native-ui/Native_ui.h>
#import <iDev.h>
#import "iToast.h"
#import "OKHttp.h"


@interface MyInterceptor:NSObject <iInterceptor>

@end
@implementation MyInterceptor {
    
}
 
- (nonnull NSMutableURLRequest *)intercept:(nonnull AFHTTPSessionManager *)af withRequest:(nonnull iRequest *)request {
    af.requestSerializer  = [AFHTTPRequestSerializer serializer];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];

    af.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

    [af.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [af.requestSerializer setTimeoutInterval:15];
    return nil;

}

@end


//////////////////////////
@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    id ok = [OKHttp new];
    [ok addInterceptor:[MyInterceptor new]];
    [ok build:({
            iRequest* request = [iRequest new];
            request.method=@"GET";
            request.baseurl=@"https://www.baidu.com";
            request.path=@"/";
            request;
        })
    ];
    [ok send:^(id  _Nonnull result, NSError * _Nonnull error) {
        if(error){
            [XENP(iToast) toast:[error localizedDescription]];
        }else{
            [XENP(iToast) toast:@"success"];
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

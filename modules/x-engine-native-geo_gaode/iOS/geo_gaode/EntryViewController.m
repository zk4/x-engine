//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iGeo_gaode.h"
#import "Native_geo_gaode.h"
 
@interface EntryViewController ()

@property(nonatomic,strong) id<iGeo_gaode> geo_gaode;

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    BOOL isSuccess = [_geo_gaode initSDKByConfig:@{@"keyString":@"c68c60fb8801d81927bb6746a93a6fce"}];
    if (isSuccess) {
        [_geo_gaode geoSinglePositionResult:^(NSDictionary *reDic){
            for (NSString *keyString in [reDic allKeys]) {
                NSLog(@"位置信息==%@:%@",keyString,reDic[keyString]);
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _geo_gaode = [Native_geo_gaode new];
//    [self pushTestModule];

}

@end

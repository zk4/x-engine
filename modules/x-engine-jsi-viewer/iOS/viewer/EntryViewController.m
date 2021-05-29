//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iDirectManager.h"
#import "iViewer.h"
#import "CommonCrypto/CommonDigest.h"

@interface EntryViewController ()
@property(nonatomic,strong) id<iViewer> iviewer;

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

- (void) pushTestModule{
    
    id<iDirectManager> director = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iDirectManager)];
    [director push:@"omp" host:@"10.2.129.142:9111" pathname:@"" fragment:@"/" query:nil params:@{@"hideNavbar":@YES}];
    
    
//    id<iViewer> iviewer = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iViewer)];
////    NSString *url  = @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
//    NSString *url = @"http://gfsei.atguat.net.cn/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf?Expires=2563098084&AccessKey=40de0c1abb5e4506bccc56d4aee3d945&Signature=1083d55756878793fe68cf43fd599d95";
///    [iviewer openFileWithfileUrl:url fileType:@"pdf" title:@"文件"];

}

- (NSString *)md5EncryptWithString:(NSString *)string {

    if (nil == string || string.length == 0) {
        return nil;
    }
    const char *cStr = [string UTF8String];
    unsigned char result[16];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
//    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
    return [[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]] substringWithRange:NSMakeRange(8, 16)];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

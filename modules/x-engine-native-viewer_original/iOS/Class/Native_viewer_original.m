//
//  Native_viewer_original.m
//  viewer_original
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_original.h"
#import "XENativeContext.h"
#import <x-engine-native-store/iStore.h>
#import <QuickLook/QuickLook.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Unity.h"
#import "QLPreviewCustomItem.h"
#import "CommonCrypto/CommonDigest.h"

#define DEFAULT_KEY  @"Native_viewer_orgi:defaultState"

@interface Native_viewer_original()<QLPreviewControllerDataSource,QLPreviewControllerDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{ }
@property (strong, nonatomic)QLPreviewController *previewController;
@property (nonatomic, assign) id<iStore>store;
///文件全路径
@property (nonatomic, copy)NSString *fileUrl;
///文件标题
@property (nonatomic, copy)NSString *titleString;
///文件网址加密后的字符串
@property (nonatomic, copy)NSString *encryptUrl;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableDictionary *typeDict;
@end

@implementation Native_viewer_original
NATIVE_MODULE(Native_viewer_original)

- (NSString *)moduleId{
    return @"com.zkty.native.viewer_original";
}

- (int) order{
    return 0;
}

- (NSMutableDictionary *)typeDict {
    if (!_typeDict) {
        _typeDict = [NSMutableDictionary dictionary];
        [_typeDict setValue:@"doc" forKey:@"application/msword"];
        [_typeDict setValue:@"docx" forKey:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document"];
        [_typeDict setValue:@"pdf" forKey:@"application/pdf"];
        [_typeDict setValue:@"ppt" forKey:@"application/vnd.ms-powerpoint"];
        [_typeDict setValue:@"pptx" forKey:@"application/vnd.openxmlformats-officedocument.presentationml.presentation"];
        [_typeDict setValue:@"xls" forKey:@"application/vnd.ms-excel"];
        [_typeDict setValue:@"xlsx" forKey:@"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"];
    }
    return _typeDict;
}

- (void)afterAllNativeModuleInited{
    self.store = [[XENativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
}

- (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type title:(NSString *)title {
    self.previewController  = [[QLPreviewController alloc] init];
    self.previewController.dataSource = self;
    [self.previewController setDelegate:self];
    
    self.encryptUrl = [[self md5EncryptWithString:url] stringByAppendingString:[NSString stringWithFormat:@".%@", type]];
    self.fileUrl= url;
    self.titleString = title;
    self.hud = [MBProgressHUD showHUDAddedTo:[Unity sharedInstance].getCurrentVC.view animated:YES];
    self.hud.userInteractionEnabled = YES;
    self.hud.removeFromSuperViewOnHide = YES;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *localPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:self.encryptUrl];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:localPath]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 10;
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.hud.detailsLabel.text = [NSString stringWithFormat:@"正在下载：%.2f %%",downloadProgress.fractionCompleted*100];
            });
            NSLog(@"file download %@",[NSString stringWithFormat:@"download progress：%.2f %%",downloadProgress.fractionCompleted*100]) ;
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:self.encryptUrl];///下载完的本地路径
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
            NSDictionary *dict = r.allHeaderFields;
            NSString *responseType = dict[@"content-type"];
            if ([self.typeDict[responseType] isEqualToString:type]) {
                self.fileUrl = filePath.absoluteString;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!error) {///success
                        [[Unity sharedInstance].getCurrentVC presentViewController:self.previewController animated:YES completion:nil];
                    } else {
                        [self.hud hideAnimated:YES];
                        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"下载失败" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *canleaction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                            NSLog(@"点击了取消按钮");
                        }];
                        [ac addAction:canleaction];
                        [[Unity sharedInstance].getCurrentVC presentViewController:ac animated:YES completion:nil];
                    }
                });
            } else {
                [self.hud hideAnimated:YES];
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"源文件类型不正确, 请核对传入的fileType" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *enter = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
                [ac addAction:enter];
                [[Unity sharedInstance].getCurrentVC presentViewController:ac animated:YES completion:nil];
                NSLog(@"%@", localPath);
                [fileManager removeItemAtPath:localPath error:nil];
            }
        }];
        [downloadTask resume];
    } else {
        NSURL *documentsDirectoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        self.fileUrl = [[documentsDirectoryURL URLByAppendingPathComponent:localPath.lastPathComponent] absoluteString];
        [[Unity sharedInstance].getCurrentVC presentViewController:self.previewController animated:YES completion:nil];
    }
}

- (NSString *)getIconUrl {
    return @"";
}

- (NSString *)getName {
    return @"阅读器";
}

- (NSArray<NSString *> *)getTypes {
    return  @[@"pdf", @"doc", @"xls", @"xlsx", @"rtf",@"txt",@"csv", @"docx", @"pptx", @"ppt"];
}
 
- (void)setDefault:(BOOL)val {
    [self.store set:DEFAULT_KEY val:[NSNumber numberWithBool:val]];
}

- (BOOL)isDefault {
    return [[self.store get:DEFAULT_KEY ] boolValue];
}

#pragma mark - QLPreviewControllerDataSource
///需要显示的文件的个数
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController {
    return 1;
}

///返回要打开文件的地址，包括网络或者本地的地址
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:self.fileUrl];
    QLPreviewCustomItem *item = [[QLPreviewCustomItem alloc] initWithTitle:self.titleString url:url];
    return item;
    
}

///控制器在即将消失后调用
- (void)previewControllerWillDismiss:(QLPreviewController*)controller {
    [self.hud hideAnimated:YES];
}

///控制器消失后调用
- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    self.previewController = nil;
    self.previewController.dataSource = nil;
    self.previewController.delegate = nil;
}

///MD5
- (NSString *)md5EncryptWithString:(NSString *)string {
    if (nil == string || string.length == 0) {
        return nil;
    }
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
@end
#undef  DEFAULT_KEY

 

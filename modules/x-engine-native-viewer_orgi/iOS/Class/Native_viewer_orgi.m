//
//  Native_viewer_orgi.m
//  viewer_orgi
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_orgi.h"
#import "NativeContext.h"
#import "AFNetworking.h"
#import "Unity.h"
#import <x-engine-native-store/iStore.h>
#import <QuickLook/QuickLook.h>
#define DEFAULT_KEY  @"Native_viewer_orgi:defaultState"
#define DEFAULT_SAVE_PLACE_KEY  @"Native_viewer_orgi:saveFileState"

@interface Native_viewer_orgi()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (strong, nonatomic)QLPreviewController *previewController;
@property (nonatomic, assign) id<iStore>store;
@property (nonatomic, copy)NSString *fileUrl;
@end

@implementation Native_viewer_orgi
NATIVE_MODULE(Native_viewer_orgi)


 - (NSString*) moduleId{
    return @"com.zkty.native.viewer_orgi";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    
    self.store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];

}

- (instancetype)init
{
    self = [super init];
    ///iWork文档、微软Office97以上版本的文档、RTF文档、PDF文件、图片文件、文本文件和CSV文件
    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.dataSource  = self;
    [self.previewController setDelegate:self];
    return self;
}


- (BOOL)isConformFileOpenTypeList:(NSArray *)list currectFileType:(NSString *)type
{
    __block BOOL boo = false;
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([type isEqualToString:list[idx]]){
            boo = YES;
            *stop = YES;
        }else{
            boo = NO;
        }
    }];
    return boo;

}
- (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type callBack:(void(^_Nullable)(NSString *__nullable filepath))callBack
{
    self.fileUrl= url;
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:url.lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [self.store set:DEFAULT_SAVE_PLACE_KEY val:[NSNumber numberWithBool:[fileManager fileExistsAtPath:filePath]]];
    
    ///文件是否存在本地磁盘
    if ([[self.store get:DEFAULT_SAVE_PLACE_KEY] boolValue] == NO) {
        ///网络文件下载 单独抽取
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
            NSLog(@"file download %@",[NSString stringWithFormat:@"download progress：%.2f %%",downloadProgress.fractionCompleted*100]) ;
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:filePath.lastPathComponent];///下载完的本地路径
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//            [self saveState:YES];
            self.fileUrl = filePath.absoluteString;
            [self.store set:DEFAULT_SAVE_PLACE_KEY val:[NSNumber numberWithBool:YES]];
            [[Unity sharedInstance].getCurrentVC presentViewController:self.previewController animated:YES completion:nil];
            
        }];
        [downloadTask resume];
    }else{
        NSURL *documentsDirectoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        self.fileUrl = [[documentsDirectoryURL URLByAppendingPathComponent:filePath.lastPathComponent] absoluteString];
        [[Unity sharedInstance].getCurrentVC presentViewController:self.previewController animated:YES completion:nil];
    }
}

- (NSString *)getIconUrl {
    /// TODO:
    return @"";
}

- (NSString *)getName {
    return @"native.viewer_orgi";
}

- (NSArray<NSString *> *)getTypes {
    return  @[@"pdf",@"doc",@"xls",@"rtf",@"txt",@"csv"];
}
 

- (void)setDefault:(BOOL)val {
    [self.store set:DEFAULT_KEY val:[NSNumber numberWithBool:val]];

}

- (BOOL)isDefault {
    return [[self.store get:DEFAULT_KEY ] boolValue];
}

#pragma mark - QLPreviewControllerDataSource
///需要显示的文件的个数
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}
///返回要打开文件的地址，包括网络或者本地的地址
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    NSURL * url = [NSURL URLWithString:self.fileUrl];
    return url;
}
///控制器在即将消失后调用
- (void)previewControllerWillDismiss:(QLPreviewController*)controller
{
    
}
///控制器消失后调用
- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{

}

@end
 

#undef  DEFAULT_KEY

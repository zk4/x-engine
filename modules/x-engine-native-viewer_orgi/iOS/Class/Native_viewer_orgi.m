//
//  Native_viewer_orgi.m
//  viewer_orgi
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer_orgi.h"
#import "NativeContext.h"
#import "AFNetworking.h"
#import <x-engine-native-store/iStore.h>

@interface Native_viewer_orgi()
{ }
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iViewer>> * viewerDict;

@property (nonatomic, strong) id<iViewer>iviewer;

@property (nonatomic, strong) id<iStore>store;


@end

@implementation Native_viewer_orgi
NATIVE_MODULE(Native_viewer_orgi)
@synthesize defaultState;

 - (NSString*) moduleId{
    return @"com.zkty.native.viewer_orgi";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
    
    self.store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];

    self.iviewer = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iViewer)];
    [self.viewerDict setObject:self.iviewer forKey:[self moduleId]];
}

- (instancetype)init
{
    self = [super init];
    self.viewerDict = [NSMutableDictionary new];
    return self;
}
- (nonnull NSArray *)modulTypeList{
    return  @[@"pdf",@"doc",@"xls",@"rtf",@"txt",@"csv"];
}

- (void)setDefaultState:(BOOL)defaultState{
    [self.store set:[self moduleId] val:[NSNumber numberWithBool:defaultState]];
    [self.store saveTodisk];
}
- (BOOL)getDefaultState{
    return  [[self.store get:[self moduleId]] boolValue];
}
- (void)openFileWithfileUrl:(NSString *)url fileType:(NSString *)type callBack:(void(^)(NSString *__nullable filepath))callBack
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:url.lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [self saveState:[fileManager fileExistsAtPath:filePath]];
    [self.store set:@"saveFileState" val:[NSNumber numberWithBool:[fileManager fileExistsAtPath:filePath]]];
    [self.store saveTodisk];
    ///文件是否存在本地磁盘
    if ([[self.store get:@"saveFileState"] boolValue] == NO) {
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
            [self.store set:@"saveFileState" val:[NSNumber numberWithBool:YES]];
            [self.store saveTodisk];
            callBack(filePath.absoluteString);
        }];
        [downloadTask resume];
    }else{
        NSURL *documentsDirectoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:filePath.lastPathComponent];
        callBack(url.absoluteString);
    }
}






@end
 

//
//  Native_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "Native_viewer.h"
#import "NativeContext.h"

#import "AFNetworking.h"
#import <x-engine-native-store/iStore.h>

@interface Native_viewer()
{ }
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<iViewer>> * viewers;
@end

@implementation Native_viewer
NATIVE_MODULE(Native_viewer)
@synthesize defaultState;

- (NSString*) moduleId{
    return @"com.zkty.native.viewer";
}

- (int) order{
    return 0;
}

- (nonnull NSString *)modulName{
    return @"native.viewer";
}

- (void)afterAllNativeModuleInited{
    NSArray* modules= [[NativeContext sharedInstance]  getModulesByProtocol:@protocol(iViewer)];
     for(id<iViewer> viewer in modules){
         [self.viewers setObject:viewer forKey:[viewer modulName]];
     }
}

- (instancetype)init
{
    self = [super init];
    self.viewers=[NSMutableDictionary new];
    return self;
}

- (void)setDefaultState:(BOOL)defaultState{
    id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
    [store set:[self moduleId] val:[NSNumber numberWithBool:defaultState]];
    [store saveTodisk];
}

- (BOOL)getDefaultState{
    id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
    return [[store get:[self moduleId]] boolValue];
}

- (nonnull NSArray *)modulTypeList{
    return  @[@"pdf",@"doc",@"xls",@"rtf",@"txt",@"csv"];
}

- (void)openFileWithfileUrl:(NSString *)url fileType:(NSString *)type callBack:(void(^)(NSString *__nullable filepath))callBack
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:url.lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [self saveState:[fileManager fileExistsAtPath:filePath]];
    id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
    [store set:@"saveFileState" val:[NSNumber numberWithBool:[fileManager fileExistsAtPath:filePath]]];
    [store saveTodisk];
    ///文件是否存在本地磁盘
    if ([[store get:@"saveFileState"] boolValue] == NO) {
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
            id<iStore>store = [[NativeContext sharedInstance] getModuleByProtocol:@protocol(iStore)];
            [store set:@"saveFileState" val:[NSNumber numberWithBool:YES]];
            [store saveTodisk];
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
 

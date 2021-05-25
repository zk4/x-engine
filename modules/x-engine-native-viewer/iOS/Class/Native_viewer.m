//
//  Native_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//  管理类实现


#import "Native_viewer.h"
#import "XENativeContext.h"

#import "AFNetworking.h"
#import "iViewer.h"
#import "Unity.h"
#import <x-engine-native-store/iStore.h>

@interface Native_viewer()
{ }
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSMutableArray<id<iViewer>>*> *viewers;
@end

@implementation Native_viewer
NATIVE_MODULE(Native_viewer)
- (NSString*) moduleId{
    return @"com.zkty.native.viewer";
}

- (int) order{
    return 0;
}
- (instancetype)init
{
    self = [super init];
    self.viewers = [NSMutableDictionary new];
    return self;
}
///可用的模块数量 list
- (void)afterAllNativeModuleInited
{
    NSArray *modules= [[XENativeContext sharedInstance]  getModulesByProtocol:@protocol(iViewer)];
     for(id<iViewer> viewer in modules){
         for(NSString* type in [viewer getTypes] )
         {
             NSMutableArray* array = [self.viewers objectForKey:type];
             if(!array){
                 array= [NSMutableArray new];
                 [self.viewers setObject:array forKey:type];
             }
             [array addObject:viewer];
         }
     }
}

//@"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"

- (id<iViewer>) getDefaultViewer:(NSString*) type{
    NSMutableArray* viewers = [self.viewers objectForKey:type];
    for(id<iViewer> v in viewers){
        if([v isDefault])return v;
    }
    return NULL;
}
- (void)openFileWithfileUrl:(NSString * _Nonnull)url fileType:(NSString * _Nonnull)type callBack:(void (^ _Nullable)(NSString * _Nullable))callBack {
    
   NSMutableArray* viewers = [self.viewers objectForKey:type];
    if(!viewers){
        //todo
        // alert 不支持类型
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"不支持类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else if(viewers.count==1){
        // todo
        // 直接打开
        [viewers[0] openFileWithfileUrl:url fileType:type callBack:^(NSString * _Nullable filepath) {}];
    }
    else if(viewers.count>1){
        // todo
        id<iViewer> defaultViewer = [self getDefaultViewer:type];
        if(defaultViewer){
            //有默认，用默认打开
            [defaultViewer openFileWithfileUrl:url fileType:type callBack:nil];
        }else{
            //没有默认 弹框选择，设置默认，用默认打开
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //todo 取得 viewers 所有 names
            for(id<iViewer> viewer in viewers){
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:viewer.getName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
                    [viewer openFileWithfileUrl:url fileType:type callBack:^(NSString * _Nullable filepath) {
//                        [self.previewController refreshCurrentPreviewItem];
                    }];
                    
                }];
                [actionSheet addAction:alertAction];
            }
            
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
            }];
            [actionSheet addAction:action3];
            [[Unity sharedInstance].getCurrentVC presentViewController:actionSheet animated:YES completion:nil];
        }
    }
  
}

@end
 

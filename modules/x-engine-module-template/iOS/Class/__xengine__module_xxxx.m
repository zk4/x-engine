//
//  xengine__module_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_xxxx.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>

@interface __xengine__module_xxxx()
{
    NSTimer * timer ;
    ContinousDTO* adto;
    void(^hanlder)(id value,BOOL isComplete);
    int value;
    NSString* event;

}
@end

@implementation __xengine__module_xxxx
 
 
  

- (void)_abc:(NSString *)dto complete:(void (^)(BOOL))completionHandler {
    NSLog(@"%@",dto);
}

- (void)_haveArgNoRet:(SheetDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
}

- (void)_haveArgRetPrimitive:(SheetDTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
}

- (void)_haveArgRetSheetDTO:(SheetDTO *)dto complete:(void (^)(SheetDTO *, BOOL))completionHandler {
    
}

- (void)_noArgNoRet:(void (^)(BOOL))completionHandler {
    
}

- (void)_noArgRetPrimitive:(void (^)(NSString *, BOOL))completionHandler {
    
}

- (void)_noArgRetSheetDTO:(void (^)(SheetDTO *, BOOL))completionHandler {
    
}
 

- (void)_ReturnInPromiseThen:(id)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
    completionHandler(@"hello,ret",TRUE);
     
}

-(void)onTimer:t{
    if(value!=-1){
        
        ContinousDTO* dto= (ContinousDTO*) adto;
        value--;
        NSString* v= [NSString stringWithFormat:@"%d",value];
        // 主动调用 js
        [self callJS:dto.__event__ args:v retCB:^(id  _Nullable value) {
            //处理__event__ 的返回值
            NSLog(@"%@",value);
        }];
    }else{
        hanlder(0,YES);
        hanlder=nil;
        [timer invalidate];
        timer=nil;
    }
}

-(void)sendingMesg{
    if(value!=-1){


        ContinousDTO* dto= (ContinousDTO*) adto;
        value--;
        NSString* v= [NSString stringWithFormat:@"%d",value];
            [[RecyleWebViewController webview] callHandler:dto.__event__ arguments:v completionHandler:^(id  _Nullable value) {
                //处理返回值
                NSLog(@"%@",value);
            }];
    }else{
        hanlder(0,YES);
        hanlder=nil;
        [timer invalidate];
        timer=nil;
    }
}

- (void)_repeatReturn__ret__:(id)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    adto=dto;
    value=10;
    hanlder=completionHandler;
    if(hanlder){
        hanlder(0,YES);
    }
    if(timer){
        [timer invalidate];
    }

    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:dto
                                             repeats:YES];
}
 

 

- (void)_registerEvent:(CustomEvent *)dto complete:(void (^)(BOOL))completionHandler {
    completionHandler(TRUE);
}

- (void)_triggerNativeBroadCast:(void (^)(BOOL))completionHandler {
    [self callJS:@"com.zkty.module.engine.broadcast" args:@[@"hello"] retCB:^(id  _Nullable ret) {
        
    }];
}

 
 



 








@end
 

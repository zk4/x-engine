//
//  xengine__module_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_xxxx.h"
#import <XEngineContext.h>
#import <micros.h>


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
- (void)_repeatReturn__ret__:(id)dto complete:(void (^)(NSString *, BOOL))completionHandler {

    value=10;
    hanlder=completionHandler;
  
    if(timer){
        [timer invalidate];
    }

    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(repeat_ret:)
                                            userInfo:nil
                                             repeats:YES];
}
 
-(void)repeat_ret:t{
    if(value!=-1){
        value--;
        NSString* v= [NSString stringWithFormat:@"%d",value];
        hanlder(v,NO);
    }else{
        hanlder(0,YES);
        hanlder=nil;
        [timer invalidate];
        timer=nil;
    }
}
- (void)_repeatReturn__event__:(id)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    adto=dto;
    value=10;
    if(hanlder){
        hanlder(0,YES);
    }
    hanlder=completionHandler;
   
    if(timer){
        [timer invalidate];
    }

    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(repeat_event:)
                                            userInfo:dto
                                             repeats:YES];
}

-(void)repeat_event:t{
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
        [timer invalidate];
        timer=nil;
    }
}
 
- (void)_broadcastOn:(void (^)(BOOL))completionHandler {
    //要注意. 这里仅是删除 _broadcastOn 的 JS 回调方法.
    completionHandler(TRUE);
}

- (void)_triggerNativeBroadCast:(void (^)(BOOL))completionHandler {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];

    NSDate *currentDate = [NSDate date];
    NSString *dateString = [formatter stringFromDate:currentDate];

    [self broadcast:@[@"hello",@"broadcast",dateString]];
    //要注意. 这里仅是删除 _triggerNativeBroadCast 的回调,而不是删除 broadcast 的回调.
    completionHandler(TRUE);
}
 

- (void)_broadcastOff:(void (^)(BOOL))completionHandler {

}

- (void)_anonymousType:(_2_com_zkty_module_xxxx_DTO *)dto complete:(void (^)(_0_com_zkty_module_xxxx_DTO *, BOOL))completionHandler {
    completionHandler(dto,TRUE);
}

 


 








@end
 

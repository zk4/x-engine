//
//  __xengine__module_UIModule.m
//  UIModule
//
//  Created by edz on 2020/7/21.
//  Copyright © 2020 edz. All rights reserved.
//

#import "__xengine__module_UIModule.h"
#import "XEngineContext.h"
#import "UIImage+XEnging_UI.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <x-engine-module-tools/MBProgressHUD+Toast.h>
#import "micros.h"
#import "JSONToDictionary.h"
#import "Unity.h"
#import <x-engine-module-tools/UIViewController+.h>
#import <x-engine-module-tools/UIColor+HexString.h>
#import <x-engine-module-engine/MircroAppController.h>
#import <XEngineWebView.h>
#import "UIBlockButton.h"
@interface __xengine__module_UIModule() <UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic,strong) NSMutableArray *pickerViewData;

/********************pickerView********************/
@property (nonatomic, strong) UIView *pickerBackgroundView;
@property (nonatomic, assign) int pickerViewRowHeight;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *pickerTooBarView;
@property (nonatomic, copy) NSString *pickerResultOne;
@property (nonatomic, copy) NSString *pickerResultTwo;
@property (nonatomic, copy) NSString *pickerResultThree;
@property (nonatomic, copy) NSString *pickerResultFour;
/********************pickerView********************/
@end

@implementation __xengine__module_UIModule

- (instancetype)init {
    self = [super init];
    return self;
}

- (NSString *)moduleId {
    return @"com.zkty.module.ui";
}

- (void)showSuccessToast:(NSString *)jsonString complate:(XEngineCallBack)completionHandler {
    NSDictionary *param = [JSONToDictionary toDictionary:jsonString];
    
    NSTimeInterval time = 2;
    if (param) {
        NSString *duration =[NSString stringWithFormat:@"%@",param[@"duration"]];
        NSString *title = param[@"title"];
        if (duration.doubleValue != 0.0 && ![duration isEqualToString:@""]) {
            time = duration.floatValue / 1000.0;
        }
        [MBProgressHUD showToastWithTitle:title image:[UIImage imageNamed:@"thcket_success"] time:time];
    } else {
        [[Unity sharedInstance].getCurrentVC showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[Unity sharedInstance].getCurrentVC hideLoading];
        });
    }
}

- (void)showFailToast:(NSString *)jsonString complate:(XEngineCallBack)completionHandler {
    NSDictionary *param = [JSONToDictionary toDictionary:jsonString];
    NSTimeInterval time = 2;
    if (param) {
        NSString *duration =[NSString stringWithFormat:@"%@",param[@"duration"]];
        NSString *title = param[@"title"];
        if (duration.doubleValue != 0.0 && ![duration isEqualToString:@""]) {
            time = duration.floatValue / 1000.0;
        }
        [MBProgressHUD showToastWithTitle:title image:[UIImage imageNamed:@"Ticket_fail"] time:time];
    } else {
        [[Unity sharedInstance].getCurrentVC showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[Unity sharedInstance].getCurrentVC hideLoading];
        });
    }
}

 
- (void)hideToast:(NSString *)jsonString callBack:(XEngineCallBack)completionHandler {
    [[Unity sharedInstance].getCurrentVC hideLoading];
    [self hiddenHudToast:[Unity sharedInstance].topView];
}

- (void)hiddenHudToast:(UIView *)view {
    [[Unity sharedInstance].getCurrentVC hideLoading];
    [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark - Loading
- (void)showLoading:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler {
    @try {
        NSString *title = param[@"title"];
        if ([self checkRequiredParam:title name:@"title"]) {
            [[Unity sharedInstance].getCurrentVC showLoading:title];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)hideLoading:(NSString *)jsonString complate:(XEngineCallBack)completionHandler {
    [[Unity sharedInstance].getCurrentVC hideLoading];
}

#pragma mark - Alert
//- (void)showModal:(NSDictionary *)param complate:(XEngineCallBack)completionHandler {
//    NSString *title = param[@"title"];
//    if ( [self checkRequiredParam:title name:@"title"]) {
//        NSString *message = param[@"content"];
//        BOOL showCancel =[param[@"showCancel"] boolValue];
//        if (showCancel) {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message cancelTitle:@"取消" sureTitle:@"确定" cancelHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",0]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            } sureHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",1]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            }];
//        } else {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",1]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            }];
//        }
//    }
//}


- (void)showActionSheet:(NSDictionary *)param complate:(XEngineCallBack)completionHandler {
    @try{
        NSString *title = param[@"title"];
        NSString *message = param[@"content"];
        NSArray *itemList = param[@"itemList"];
        if ([self checkRequiredParam:itemList name:@"itemList"]) {
            NSMutableArray *actionHandlers = [NSMutableArray array];
            for (int i = 0; i < itemList.count; i++) {
                ActionHandler handler = ^(UIAlertAction * _Nonnull action){
                    NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",i]};
                    completionHandler([JSONToDictionary toString:callBackParam],YES);
                };
                [actionHandlers addObject:handler];
            }
            
            [[Unity sharedInstance].getCurrentVC showActionSheetWithTitle:title message:message cancelTitle:@"取消" sureTitles:itemList cancelHandler:^(UIAlertAction * _Nonnull action) {
            } sureHandlers:actionHandlers];
        }
    }@catch (NSException *exception) {}
}


/********************pickerView********************/
- (NSMutableArray *)pickerViewData {
    if (!_pickerViewData) {
        _pickerViewData = [NSMutableArray array];
    }
    return _pickerViewData;
}

- (void)showPickerView:(NSDictionary *)params complate:(XEngineCallBack)completionHandler {
    // 左边文字
    NSString *leftText = [NSString stringWithFormat:@"%@", params[@"leftText"]];
    // 左边文字大小
    int leftTextSize = [params[@"leftTextSize"] intValue];
    // 左边文字颜色
    NSString *leftTextColor = [NSString stringWithFormat:@"%@", params[@"leftTextColor"]];
    
    // 右边文字
    NSString *rightText = [NSString stringWithFormat:@"%@", params[@"rightText"]];
    // 右边文字大小
    int rightTextSize = [params[@"rightTextSize"] intValue];
    // 右边文字颜色
    NSString *rightTextColor = [NSString stringWithFormat:@"%@", params[@"rightTextColor"]];
    
    // pickerView 背景颜色
    NSString *backgroundColor = [NSString stringWithFormat:@"%@", params[@"backgroundColor"]];
    // pickerView 背景透明度
    NSString *backgroundColorAlpha = [NSString stringWithFormat:@"%@", params[@"backgroundColorAlpha"]];
    double alpha = [backgroundColorAlpha doubleValue];
    
    // pickerView 背景色
    NSString *bgColor = [NSString stringWithFormat:@"%@", params[@"pickerBackgroundColor"]];
    // pickerView 高度
    NSInteger pickerViewHeight = [params[@"pickerHeight"] intValue];
    // pickerView 行高
    self.pickerViewRowHeight = [params[@"rowHeight"] intValue];
    // pickerView 数据
    self.pickerViewData = params[@"data"];
    
    // toolbar背景颜色
    NSString *toolBarBackgroundColor = [NSString stringWithFormat:@"%@", params[@"toolBarBackgroundColor"]];
    
    // pickerView背景
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:backgroundColor];
    view.frame = CGRectMake(0, 0, kWidth, kHeight);
    view.alpha = alpha;
    
    // pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kHeight-pickerViewHeight, kWidth, pickerViewHeight)];
    pickerView.backgroundColor = [UIColor colorWithHexString:bgColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // toolBarView
    UIView *pickerToolBarView = [[UIView alloc] init];
    pickerToolBarView.frame = CGRectMake(0, CGRectGetMinY(pickerView.frame), kWidth, 44);
    pickerToolBarView.backgroundColor = [UIColor colorWithHexString:toolBarBackgroundColor];
    
    // pickerView左边按钮
    
    UIBlockButton *leftBtn = [UIBlockButton buttonWithType:UIButtonTypeCustom];
    
 
    [leftBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIBlockButton *sender){
        [self  didClickPickerLeftBtn];
    }];
    leftBtn.frame = CGRectMake(10, 0, 100, 44);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:leftTextSize];
    [leftBtn setTitle:leftText forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(didClickPickerLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:[UIColor colorWithHexString:leftTextColor] forState:UIControlStateNormal];
    // pickerView右边按钮
    UIBlockButton *rightBtn = [UIBlockButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(pickerToolBarView.frame.size.width - 110, 0, 100, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:rightTextSize];
    [rightBtn setTitle:rightText forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(didClickPickerRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIBlockButton *sender){
          [self  didClickPickerRightBtn];
      }];
    [rightBtn setTitleColor:[UIColor colorWithHexString:rightTextColor] forState:UIControlStateNormal];
    [pickerToolBarView addSubview:leftBtn];
    [pickerToolBarView addSubview:rightBtn];
    
    [[Unity sharedInstance].getCurrentVC.view addSubview:view];
    [[Unity sharedInstance].getCurrentVC.view addSubview:pickerView];
    [[Unity sharedInstance].getCurrentVC.view addSubview:pickerToolBarView];
    
    self.pickerBackgroundView = view;
    self.pickerView = pickerView;
    self.pickerTooBarView = pickerToolBarView;
}

- (void)didClickPickerLeftBtn {
    [self.pickerView removeFromSuperview];
    [self.pickerTooBarView removeFromSuperview];
    [self.pickerBackgroundView removeFromSuperview];
}

- (void)didClickPickerRightBtn {
    [self.pickerView removeFromSuperview];
    [self.pickerTooBarView removeFromSuperview];
    [self.pickerBackgroundView removeFromSuperview];
    
    NSMutableString *pickerResult = [NSMutableString string];
    if (self.pickerViewData.count == 2) {
        pickerResult = [NSMutableString stringWithFormat:@"%@,%@", _pickerResultOne, _pickerResultTwo];
    } else if (self.pickerViewData.count == 3) {
        pickerResult = [NSMutableString stringWithFormat:@"%@,%@,%@", _pickerResultOne, _pickerResultTwo, _pickerResultThree];
    } else if (self.pickerViewData.count == 4) {
        pickerResult = [NSMutableString stringWithFormat:@"%@,%@,%@,%@", _pickerResultOne, _pickerResultTwo, _pickerResultThree, _pickerResultFour];
    }

    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    if ([topVC isKindOfClass:MircroAppController.class]){
        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
        NSDictionary *dict = @{@"data" : pickerResult };
        NSString *args = [JSONToDictionary toString:dict];
        [webVC.webview callHandler:@"handlerPickerViewEnter" arguments:@[args] completionHandler:^(id  _Nullable value) {}];
    }
}


#pragma mark -  <UIPickerViewDataSource, UIPickerViewDelegate>
// 有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerViewData.count;
}
// 行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerViewData[component] count];
}
// 列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return self.pickerViewData[component][row];
}

// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *rowResult = _pickerViewData[component][row];
    if (_pickerViewData.count == 2) {
         switch (component) {
             case 0:
                 self.pickerResultOne = rowResult;
                 break;
             case 1:
                 self.pickerResultTwo = rowResult;
                 break;
             default:
                 break;
         }
    } else if (_pickerViewData.count == 3) {
        switch (component) {
            case 0:
                self.pickerResultOne = rowResult;
                break;
            case 1:
                self.pickerResultTwo = rowResult;
                break;
            case 2:
                self.pickerResultThree = rowResult;
                break;
            default:
                break;
        }
    } else if (_pickerViewData.count == 4) {
        switch (component) {
            case 0:
                self.pickerResultOne = rowResult;
                break;
            case 1:
                self.pickerResultTwo = rowResult;
                break;
            case 2:
                self.pickerResultThree = rowResult;
                break;
            case 3:
                self.pickerResultFour = rowResult;
                break;
            default:
                break;
        }
    }
}

// 行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.pickerViewRowHeight;
}
/********************pickerView********************/ 




//- (void)_showAlertAction:(ZKUIAlertDTO *)dto complete:(void (^)(BOOL))completionHandler {
//
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:dto.title message:dto.content preferredStyle:dto.isAlert ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
//    if (dto.btnItem.count > 0){
//        for (int i = 0; i < dto.btnItem.count; i++){
//            ZKUIBtnDTO *item = dto.btnItem[i];
//            UIAlertAction *action = [UIAlertAction actionWithTitle:item.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                if ([topVC isKindOfClass:[RecyleWebViewController class]]){
//                    RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//                    if (item.__event__){
//                        [webVC.webview callHandler:item.__event__ arguments:@[@(i)] completionHandler:nil];
//                    }
//                }
//            }];
//            [alert addAction:action];
//        }
//    } else {
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:action];
//    }
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//    completionHandler(YES);
//}

- (void)_showLoading:(void (^)(BOOL))completionHandler {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [[UIApplication sharedApplication].keyWindow addSubview:activityIndicator];
    //设置小菊花的frame
    activityIndicator.frame= CGRectMake(100, 100, 100, 100);
    //设置小菊花颜色
    activityIndicator.color = [UIColor redColor];
    //设置背景颜色
    activityIndicator.backgroundColor = [UIColor cyanColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    activityIndicator.hidesWhenStopped = NO;
}

//- (void)_showModal:(ZKUIModalDTO *)dto complete:(void (^)(BOOL))completionHandler{
//    
//    NSString *title = dto.title;
//    if ( [self checkRequiredParam:title name:@"title"]) {
//        NSString *message = dto.content;
//        BOOL showCancel = dto.showCancel;
//        if (showCancel) {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message cancelTitle:@"取消" sureTitle:@"确定" cancelHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",0]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            } sureHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",1]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            }];
//        } else {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
//                NSDictionary *callBackParam = @{@"tapIndex": [NSString stringWithFormat:@"%d",1]};
//                completionHandler([JSONToDictionary toString:callBackParam],YES);
//            }];
//        }
//    }
//    completionHandler(YES);
//}
  

- (void)_showToast:(XEToastDTO *)dto complete:(void (^)(BOOL))completionHandler {
     NSTimeInterval time = 2;
       @try {
           NSString *title = dto.tipContent;
           if ([self checkRequiredParam:title name:@"title"]) {
               NSString *duration =[NSString stringWithFormat:@"%d",dto.duration];
               if (duration.doubleValue != 0.0 && ![duration isEqualToString:@""]) {
                   time = duration.floatValue / 1000.0;
               }
               
               NSString *icon = dto.icon;
               if ([icon isEqualToString:@"success"]) {
                   [MBProgressHUD showToastWithTitle:title image:[UIImage imageNamed:@"toast_success" inAssets:@"xengine-ui"] time:time];
               } else if ([icon isEqualToString:@"loading"]) {
                   [[Unity sharedInstance].getCurrentVC showLoading:title];
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [[Unity sharedInstance].getCurrentVC hideLoading];
                   });
               } else {
                   [MBProgressHUD showToastWithTitle:title image:nil time:time];
               }
           }
       } @catch (NSException *exception) {}
}

@end

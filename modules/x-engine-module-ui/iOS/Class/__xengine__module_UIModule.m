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
//#import <x-engine-module-tools/UIViewController+.h>
#import <x-engine-module-tools/UIColor+HexString.h>
#import <x-engine-module-engine/RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <x-engine-module-engine/Unity.h>
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
@property(nonatomic,copy)NSString * event;

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

#pragma mark - Toast

 - (void)_hideToast:(void (^)(BOOL))completionHandler {
//     [[Unity sharedInstance].getCurrentVC hideLoading];
     
//     [self hiddenHudToast:[Unity sharedInstance].topView];
 }


- (void)_hiddenHudToast:(void (^)(BOOL))completionHandler {
//    [[Unity sharedInstance].getCurrentVC hideLoading];
//    [MBProgressHUD hideHUDForView:[Unity sharedInstance].topView] animated:YES];
}

- (void)_showToast:(XEToastDTO *)dto complete:(void (^)(BOOL))completionHandler {
    NSTimeInterval time = 2;
    @try {
        NSString *title = dto.tipContent;
        if ([self checkRequiredParam:title name:@"title"]) {
            NSString *duration =[NSString stringWithFormat:@"%ld",(long)dto.duration];
            if (duration.doubleValue != 0.0 && ![duration isEqualToString:@""]) {
                time = duration.floatValue / 1000.0;
            }
            
            NSString *icon = dto.icon;
            if ([icon isEqualToString:@"success"]) {
                [MBProgressHUD showToastWithTitle:title image:[UIImage imageNamed:@"toast_success" inAssets:@"xengine-ui"] time:time];
            } else if ([icon isEqualToString:@"loading"]) {
//                [[Unity sharedInstance].getCurrentVC showLoading:title];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[Unity sharedInstance].getCurrentVC hideLoading];
                });
            } else {
                [MBProgressHUD showToastWithTitle:title image:nil time:time];
            }
        }
    } @catch (NSException *exception) {}
}


#pragma mark - Loading

- (void)_showLoading:(XETipDTO *)dto complete:(void (^)(BOOL))completionHandler {
    NSString *title = dto.tipContent;
    if ([self checkRequiredParam:title name:@"title"]) {
//        [[Unity sharedInstance].getCurrentVC showLoading:title];
    }
}

- (void)_hideLoading:(void (^)(BOOL))completionHandler {
//    [[Unity sharedInstance].getCurrentVC hideLoading];
}


#pragma mark - Alert/Modal
- (void)_showModal:(XEModalDTO *)dto complete:(void (^)(XERetDTO *, BOOL))completionHandler {
    NSString *title = dto.tipTitle;
    if ( [self checkRequiredParam:title name:@"title"]) {
//        NSString *message = dto.tipContent;
        BOOL showCancel = dto.showCancel;
        if (showCancel) {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message cancelTitle:@"取消" sureTitle:@"确定" cancelHandler:^(UIAlertAction * _Nonnull action) {
//                XERetDTO * d = [XERetDTO new];
//                d.content = [NSString stringWithFormat:@"%d",0];
//                completionHandler(d,YES);
//            } sureHandler:^(UIAlertAction * _Nonnull action) {
//                XERetDTO * d = [XERetDTO new];
//                d.content = [NSString stringWithFormat:@"%d",1];
//                completionHandler(d,YES);
//            }];
        } else {
//            [[Unity sharedInstance].getCurrentVC showAlertWithTitle:title message:message sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
//                XERetDTO * d = [XERetDTO new];
//                d.content = [NSString stringWithFormat:@"%d",1];
//                completionHandler(d,YES);
//            }];
        }
    }
}



#pragma mark - ActionSheet
- (void)_showActionSheet:(XESheetDTO *)dto complete:(void (^)(XERetDTO *, BOOL))completionHandler {
//    NSMutableArray *actionHandlers = [NSMutableArray array];
        for (int i = 0; i < dto.itemList.count; i++)
        {
//            ActionHandler handler = ^(UIAlertAction * _Nonnull action){
//
//                NSLog(@"%d",i);
//                XERetDTO * d = [XERetDTO new];
//                d.content = [NSString stringWithFormat:@"%d",i];
//                completionHandler(d, YES);
//            };
//            [actionHandlers addObject:handler];
        }
//        UIViewController*  cvc = [Unity sharedInstance].getCurrentVC;
    
//        [cvc showActionSheetWithTitle:dto.title message:dto.content cancelTitle:@"取消" sureTitles:dto.itemList cancelHandler:^(UIAlertAction * _Nonnull action) {} sureHandlers:actionHandlers];
}

#pragma mark - PickerView
- (NSMutableArray *)pickerViewData {
    if (!_pickerViewData) {
        _pickerViewData = [NSMutableArray array];
    }
    return _pickerViewData;
}

- (void)_showPickerView:(XEPickerDTO *)dto complete:(void (^)(XERetDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    // 左边文字
    NSString *leftText = [NSString stringWithFormat:@"%@", dto.leftText];
    // 左边文字大小
    NSInteger leftTextSize = dto.leftTextSize;
    // 左边文字颜色
    NSString *leftTextColor = [NSString stringWithFormat:@"%@", dto.leftTextColor];
    
    // 右边文字
    NSString *rightText = [NSString stringWithFormat:@"%@", dto.rightText];
    // 右边文字大小
    NSInteger rightTextSize = dto.rightTextSize;
    // 右边文字颜色
    NSString *rightTextColor = [NSString stringWithFormat:@"%@",dto.rightTextColor];
    
    // pickerView 背景颜色
    NSString *backgroundColor = [NSString stringWithFormat:@"%@", dto.backgroundColor];
    // pickerView 背景透明度
    NSString *backgroundColorAlpha = [NSString stringWithFormat:@"%@", dto.backgroundColorAlpha];
    double alpha = [backgroundColorAlpha doubleValue];
    
    // pickerView 背景色
    NSString *bgColor = [NSString stringWithFormat:@"%@", dto.pickerBackgroundColor];
    // pickerView 高度
    NSInteger pickerViewHeight = [dto.pickerHeight intValue];
    // pickerView 行高
    self.pickerViewRowHeight = [dto.rowHeight intValue];
    // pickerView 数据
    self.pickerViewData = [[NSMutableArray alloc]initWithArray:dto.data];
    self.pickerResultOne = self.pickerViewData[0][0];
    self.pickerResultTwo = self.pickerViewData[1][0];
    self.pickerResultThree = self.pickerViewData[2][0];
    self.pickerResultFour = self.pickerViewData[3][0];
    // toolbar背景颜色
    NSString *toolBarBackgroundColor = [NSString stringWithFormat:@"%@", dto.toolBarBackgroundColor];
    
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

- (void)_hideTabbar:(void (^)(BOOL))completionHandler {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isShowTabbar" object:@{@"isshow":@(NO)}];
    completionHandler(YES);
}


- (void)_showTabbar:(void (^)(BOOL))completionHandler {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isShowTabbar" object:@{@"isshow":@(YES)}];
    completionHandler(YES);
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
    if ([topVC isKindOfClass:RecyleWebViewController.class]) {
        
        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
        XERetDTO* d = [XERetDTO new];
        NSDictionary *dict = @{@"data" : pickerResult };
        NSString *args = [JSONToDictionary toString:dict];
        d.content = args;
        NSLog(@"ddddd%@",self.event);
        [webVC.webview callHandler:self.event arguments:@[d.content] completionHandler:^(id  _Nullable value) {}];
        
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

@end

//

#import "__xengine__module_nav.h"
#import "XEngineContext.h"
#import "PopoverViewController.h"
#import "Unity.h"
#import "UIViewController+Push_Present.h"
#import "RecyleWebViewController.h"
#import "UIColor+HexString.h"
#import "JSONToDictionary.h"
#import "xengine_protocol_network.h"
#import "micros.h"
#import "MicroAppLoader.h"
#import "UIBlockButton.h"
#import "XEOneWebViewControllerManage.h"
#import "NavUtil.h"
#import "NavSearchBar.h"
#import <XEOneWebViewPool.h>

static const NSUInteger BAR_BTN_FLAG = 10000;

@interface __xengine__module_nav () <UIPopoverPresentationControllerDelegate,UISearchBarDelegate>
@property (nonatomic, strong) UIBarButtonItem *rightBarItem; /** rightBarItem */
@property (nonatomic, strong) UIBarButtonItem *leftBarItem; /** leftBarItem */
@property (nonatomic,copy) NSString * isInput;
@property (nonatomic, weak) id<xengine_protocol_network> network;
@end

@implementation __xengine__module_nav

- (NSString *)moduleId {
    
    return @"com.zkty.module.nav";
}

- (void)onAllMoudlesInited {
    _network = [[XEngineContext sharedInstance] getModuleByProtocol:@protocol(xengine_protocol_network)];
}

- (void) downloadImg:(NSString*)url cb:(nullable void (^)(NSURLResponse * response, UIImage * _Nullable img, NSError * _Nullable error)) cb{
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//    [topVC showLoading];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [self.network downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        [topVC hideLoading];
        if(!error){
            UIImage* responseObject=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:filePath]];
            cb(response,responseObject,error);
        }else{
            NSLog(@"%@",error);
        }
        
    }];
    [downloadTask resume];
    
}
#pragma nav
///push跳转下一页
//- (void)navigatorPush:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler {
//
//
//    NavNavigatorDTO *dto = [[NavNavigatorDTO alloc] init];
//    dto.url = param[@"url"];
//    void(^change)(BOOL r) = ^(BOOL r){
//        if (completionHandler){
//            NSString *jsonStr = [JSONToDictionary toString:@{}];
//            completionHandler(jsonStr, YES);
//        }
//    };
//    [self _navigatorPush:dto complete:change];
//}
//- (void)navigatorBack:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler{
//    NavNavigatorDTO *dto = [[NavNavigatorDTO alloc] init];
//    dto.url = param[@"path"];
//    void(^change)(BOOL r) = ^(BOOL r){
//        if (completionHandler){
//            NSString *jsonStr = [JSONToDictionary toString:@{}];
//            completionHandler(jsonStr, YES);
//        }
//    };
//    [self _navigatorBack:dto complete:change];
//}

//- (void)setNavLeftBtn:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler{
//    //    if ([Unity sharedInstance].getCurrentVC.navigationController.viewControllers.count <= 1) {
//    [self addItemBarButtonWithParam:param isLeft:YES];
//    //    }
//}

//- (void)setNavRightBtn:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler{
//    [self addItemBarButtonWithParam:param isLeft:NO];
//}
//
//- (void)setNavRightMenuBtn:(NSDictionary *)param callBlock:(XEngineCallBack)completionHandler{
//    [self addItemBarButtonWithParam:param isLeft:NO];
//}

//- (void)setNavTitle:(NSDictionary *)param callBlock:(XEngineCallBack)completionHandler{
//    NSString *title = param[@"title"];
//    NSString *titleColor = param[@"titleColor"];
//    NSInteger titleSize = [param[@"titleSize"] integerValue];
//
//    if ([self checkRequiredParam:title name:@"title"]) {
//        [self setNavTitle:title withTitleColor:titleColor withTitleSize:titleSize];
//    }
//
//}

//-(void)setNavRightMoreBtn:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler{
//    [self addMoreItemBarButtonWithParam:param isLeft:NO];
//}

//-(void)setNavSearchBar:(NSDictionary *)param callBack:(XEngineCallBack)completionHandler{
//    [self addSearchBar:param];
//}

#pragma mark - fun
///切换tabbar页签
- (void)navigateSwitchTap:(NSDictionary *)data callBlock:(XEngineCallBack)completionHandler{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:UITabBarController.class]){
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        [topVC.navigationController popToRootViewControllerAnimated:YES];
        topVC.tabBarController.selectedIndex = 0;
    }
}

/////隐藏navbar
//- (void)navigateHidden:(NSDictionary *)data complate:(XEngineCallBack)completionHandler{
//    [self isHiddenNavbar:YES];
//}
//
/////显示navbar
//- (void)navigateShow:(NSDictionary *)data callBlock:(XEngineCallBack)completionHandler{
//
//    [self isHiddenNavbar:NO];
//}


//- (void)addItemBarButtonWithParam:(NSDictionary *)param isLeft:(BOOL)isLeft{
//
//    NavBtnDTO *btn = [[NavBtnDTO alloc] init];
//    btn.title = param[@"title"];
//    btn.icon = param[@"icon"];
//
//    btn.titleColor = param[@"titleColor"];
//    btn.titleSize = [[NSString stringWithFormat:@"%@", param[@"titleSize"] ?: @"16"] integerValue];
//    btn.iconSize = param[@"iconSize"];
//    btn.__event__ = param[@"__event__"];
//    if (param[@"itemList"]){
//        btn.popList = param[@"itemList"];
//    }
//    if (param[@"popList"]){
//        btn.popList = param[@"popList"];
//    }
//
//    btn.popWidth = param[@"popWidth"];
//    if (isLeft){
//        [self _setNavLeftBtn:btn complete:nil];
//    } else {
//        [self _setNavRightBtn:btn complete:nil];
//    }
//}

- (void)addMoreItemBarButtonWithParam:(NSDictionary *)params isLeft:(BOOL)isLeft{
    
    
//    NSString *clickEvent = params[@"__event__"];
    NSMutableArray<NavBtnDTO *> *btnAry = [@[] mutableCopy];
    for (int i = 0; i < params.allKeys.count; i++){
        NSDictionary *item = params[[NSString stringWithFormat:@"%d", i]];
        
        NavBtnDTO *btn = [[NavBtnDTO alloc] init];
        btn.title = item[@"title"];
        btn.icon = item[@"icon"];
        btn.titleColor = item[@"titleColor"];
        btn.titleSize = [[NSString stringWithFormat:@"%@", item[@"titleSize"] ?: @"16"] integerValue];
        btn.iconSize = item[@"iconSize"];
        btn.__event__ = item[@"__event__"];
        btn.popList = item[@"itemList"];
        //        NSArray *ary = item[@"itemList"];
        //        if (ary.count > 0){
        //            NSMutableArray *temp = [@[] mutableCopy];
        //            for (NSDictionary *i in ary) {
        //                NavPopModelDTO *dto = [[NavPopModelDTO alloc] init];
        //                dto.icon = i[@"icon"];
        //                dto.iconSize = i[@"iconSize"];
        //                dto.title = i[@"title"];
        //                [temp addObject:dto];
        //            }
        //            btn.popList = temp;
        //        }
        
        btn.popWidth = item[@"popWidth"];
        [btnAry addObject:btn];
    }
    NavMoreBtnDTO *btns = [[NavMoreBtnDTO alloc] init];
    btns.btns = [btnAry copy];
    [self _setNavRightMoreBtn:btns complete:nil];
}

- (void)showRightMenuButtonAction:(NSArray *)itemList withMenuWidth:(NSString *)menuWidht withEvent:(NSString *)event{
    
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    PopoverViewController *popover = [[PopoverViewController alloc] init];
    popover.itemList = itemList;
    popover.preferredContentSize = CGSizeMake( (menuWidht && ![menuWidht isEqualToString:@""] && ![menuWidht isEqual:[NSNull null]]) ? menuWidht.floatValue:100, itemList.count * 50);
    popover.modalPresentationStyle = UIModalPresentationPopover;
    popover.selectCellBlock = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        if (topVC.navigationController) {
            [topVC.navigationController dismissViewControllerAnimated:YES completion:^{
                RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
                NSString *indexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
                if ([NavUtil getNoEmptyString:event]){
                    [webVC.webview callHandler:event arguments:@[indexRow] completionHandler:^(id  _Nullable value) {}];
                }
            }];
        } else {
            [topVC dismissViewControllerAnimated:YES completion:^{
                RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
                NSString *indexRow = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
                if ([NavUtil getNoEmptyString:event]){
                    [webVC.webview callHandler:event arguments:@[indexRow] completionHandler:^(id  _Nullable value) {}];
                }
            }];
        }

    };
    
    UIPopoverPresentationController *popController = [popover popoverPresentationController];
    popController.canOverlapSourceViewRect = YES;
    popController.delegate = self;
    //     popController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    popController.barButtonItem = self.rightBarItem;
    [topVC presentViewController:popover animated:YES completion:nil];
}

//-(void)addSearchBar:(NSDictionary *)param{
//
//    NavSearchBarDTO *dto = [[NavSearchBarDTO alloc] init];
//
//    dto.cornerRadius = [param[@"cornerRadius"] integerValue];
//    dto.backgroundColor = param[@"backgroundColor"];
//    dto.iconSearch = param[@"iconSearch"];
//    dto.iconSearchSize = param[@"iconSearchSize"];
//    dto.iconClear = param[@"iconClear"];
//    dto.iconClearSize = param[@"iconClearSize"];
//    dto.textColor = param[@"textColor"];
//    dto.fontSize = [param[@"fontSize"] integerValue];
//    dto.placeHolder = param[@"placeHolder"];
//    dto.placeHolderFontSize = [param[@"placeHolderFontSize"] integerValue];
//    dto.isInput = [param[@"isInput"] boolValue];
//    dto.becomeFirstResponder = [param[@"becomeFirstResponder"] boolValue];
//
//    [self _setNavSearchBar:dto complete:nil];
//}


//-(void)tapGesture:(UITapGestureRecognizer *)gesture{
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//    if ([topVC isKindOfClass:RecyleWebViewController.class]){
//        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//        [webVC.webview callHandler:@"handlerNavSearchBar" arguments:@[@"0"] completionHandler:^(id  _Nullable value) {
//
//        }];
//    }
//}

#pragma mark - UIPopoverPresentationControllerDelegate
// 设立实现代理，注意要返回UIModalPresentationNone
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}




- (void)_navigatorBack:(NavNavigatorBackDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
//    if ([@"0" isEqualToString:dto.url]){
//        [[Unity sharedInstance].getCurrentVC.navigationController popToRootViewControllerAnimated:YES];
//        return;
//    }
    
    BOOL isAction = false;
    NSArray *ary = [Unity sharedInstance].getCurrentVC.navigationController.viewControllers;
    UIViewController *lastVc;
    for (UIViewController *vc in ary) {
        
        if ([vc isKindOfClass:[RecyleWebViewController class]]){
            if ([@"0" isEqualToString:dto.url]){
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:lastVc animated:YES];
                [[XEOneWebViewPool sharedInstance] clearWebView:nil];
                return;;
            }
            RecyleWebViewController *webVC = (RecyleWebViewController *)vc;
            if ([webVC.preLevelPath isEqualToString:dto.url]){
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:webVC animated:YES];
                isAction = YES;
                break;
            }
            else if ([@"/index" isEqualToString:dto.url] && [vc isKindOfClass:[RecyleWebViewController class]]){
                [[Unity sharedInstance].getCurrentVC.navigationController popToViewController:webVC animated:YES];
                isAction = YES;
                break;
            }
        }else{
            lastVc = vc;
        }
    }
    if (!isAction){
//        [[Unity sharedInstance].getCurrentVC pop];
        [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];
    }
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_navigatorPush:(NavNavigatorDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
    [[XEOneWebViewControllerManage sharedInstance] pushViewControllerWithPath:dto.url withParams:dto.params withHiddenNavbar:dto.hideNavbar];
    
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_setNavLeftBtn:(NavBtnDTO *)dto complete:(void (^)(BOOL))completionHandler {
//    if ([Unity sharedInstance].getCurrentVC.navigationController.viewControllers.count <= 1) {
        [self setBarItems:@[dto] withIsRight:NO withEvent:nil withBeginIndex:0];
//    }
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_setNavRightBtn:(NavBtnDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self setBarItems:@[dto] withIsRight:YES withEvent:nil withBeginIndex:0];
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_setNavRightMenuBtn:(NavBtnDTO *)dto complete:(void (^)(BOOL))completionHandler{
    [self setBarItems:@[dto] withIsRight:YES withEvent:nil withBeginIndex:0];
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_setNavRightMoreBtn:(NavMoreBtnDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self setBarItems:dto.btns withIsRight:YES withEvent:nil withBeginIndex:0];
    if(completionHandler){
        completionHandler(YES);
    }
}


- (void)_setNavTitle:(NavTitleDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [self setNavTitle:dto.title withTitleColor:dto.titleColor withTitleSize:dto.titleSize];
}

- (void)_setNavSearchBar:(NavSearchBarDTO *)dto complete:(void (^)(BOOL))completionHandler {
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    NavSearchBar *searchBar = [[NavSearchBar alloc] init];
    [searchBar setSearchModel:dto];
    topVC.navigationItem.titleView = searchBar;
    
    if(completionHandler){
        completionHandler(YES);
    }
}

- (void)_setSearchBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    
    if(dto.isAnimation){
        if(dto.isHidden){
            [UIView animateWithDuration:0.3 animations:^{
                topVC.navigationItem.titleView.alpha = 0;
            } completion:^(BOOL finished) {
                topVC.navigationItem.titleView = nil;
            }];
        }
    }else{
        if(dto.isHidden){
            topVC.navigationItem.titleView = nil;
        }
//        topVC.navigationItem.titleView.alpha = dto.isHidden ? 0 : 1;
    }
}

//- (void)_setNavBase:(NavDTO *)dto complete:(void (^)(BOOL))completionHandler {
//
//    [self setBarItems:dto.leftBtns withIsRight:NO withEvent:dto.__event__ withBeginIndex:0];
//    [self setBarItems:dto.rightBtns withIsRight:YES withEvent:dto.__event__ withBeginIndex:BAR_BTN_FLAG];
//    [self isHiddenNavbar:dto.isHiddenNavBar];
//    if (!dto.isHiddenNavBar){
//        [self setNavTitle:dto.title withTitleColor:dto.titleFont.textColor withTitleSize:dto.titleFont.fontSize];
//    }
//    completionHandler(YES);
//}

//- (void)_setNavLeftBtns:(NavBtns *)dto complete:(void (^)(BOOL))completionHandler {
//    [self setBarItems:dto withIsRight:NO withEvent:nil withBeginIndex:0];
//    completionHandler(YES);
//}
//
//- (void)_setNavRightBtns:(NavBtns *)dto complete:(void (^)(BOOL))completionHandler {
//    [self setBarItems:dto withIsRight:YES withEvent:nil withBeginIndex:BAR_BTN_FLAG];
//    completionHandler(YES);
//}

//- (void)_setAlertNavRightBtn:(NavBtns *)dto complete:(void (^)(BOOL))completionHandler{
//
//    [self setBarItems:dto withIsRight:YES withEvent:nil withBeginIndex:BAR_BTN_FLAG];
//    completionHandler(YES);
//}

- (void)setNavTitle:(NSString *)title withTitleColor:(NSString *)color withTitleSize:(NSInteger)size {
    
    if ([self checkRequiredParam:title name:@"title"]) {
        UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
        topVC.title = title;
        UIColor *rgbColor;
        if ([NavUtil getNoEmptyString:color]){
            rgbColor = [UIColor colorWithHexString:color];
        }
        if (rgbColor == nil){
            rgbColor = [UIColor blackColor];
        }
        float fontSize = size;
        NSDictionary *dic = @{
            NSForegroundColorAttributeName:rgbColor,
            NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
        };
        [topVC.navigationController.navigationBar setTitleTextAttributes:dic];
    }
}

- (void)isHiddenNavbar:(BOOL)isHidden{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:isHidden animated:YES];
}

-(void)_setNavBarHidden:(NavHiddenBarDTO *)dto complete:(void (^)(BOOL))completionHandler{
    
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:dto.isHidden animated:dto.isAnimation];
}

- (void)setBarItems:(NSArray<NavBtnDTO *> *)dtoNavBarAry withIsRight:(BOOL)isRight withEvent:(NSString *)event withBeginIndex:(NSUInteger)index{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    NSMutableArray *barAry = [@[] mutableCopy];
    
    if(dtoNavBarAry.count > 0) {
        
        __weak __xengine__module_nav *weakSelf = self;
        int tag = 0;
        for (NavBtnDTO *item in dtoNavBarAry) {
            NSString *title = item.title;
            NSString *icon = item.icon;
            NSString *titleColor = item.titleColor;
            NSString *itemEvent = item.__event__;
            NSArray *iconSizeArray = item.iconSize;
            CGSize iconSize = [NavUtil getIconSize:iconSizeArray];
            
            if (isRight && (![NavUtil getNoEmptyString:title] && ![NavUtil getNoEmptyString:icon])){
                [self showErrorAlert:@"title或icon"];
                continue;;
            }
            UIBlockButton *itemButton = [UIBlockButton buttonWithType:UIButtonTypeCustom];
            UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
            
            itemButton.tag = BAR_BTN_FLAG + tag + index;
            
            
            itemButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            //iOS 设置button文字过长而显示省略号的解决办法
            itemButton.titleLabel.adjustsFontSizeToFitWidth = YES;

            [itemButton handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIBlockButton *sender){
                
                if(item.popList && item.popList.count > 0){
                    weakSelf.rightBarItem = btnItem;
                    [weakSelf showRightMenuButtonAction:item.popList withMenuWidth:item.popWidth withEvent:item.__event__];
                } else {
                    NSString *eventName = nil;
                    if ([NavUtil getNoEmptyString:itemEvent]){
                        eventName = itemEvent;
                    } else if ([NavUtil getNoEmptyString:event]){
                        eventName = event;
                    }
                    if (eventName){
                        if ( [topVC isKindOfClass:[RecyleWebViewController class]] ){
                            
                            RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
                            [webVC.webview callHandler:eventName arguments:@[@(tag + index)] completionHandler:nil];
                        }
                    }else{
                        [[Unity sharedInstance].getCurrentVC.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];
            
            if ([NavUtil getNoEmptyString:title]){
                [itemButton setTitle:title forState:UIControlStateNormal];
            }
            
//            itemButton.frame = CGRectMake(0, 0, iconSize.width, iconSize.height);
            
            if(item.__event__){
                if ([NavUtil getNoEmptyString:icon]) {
                    UIImage * image = [NavUtil getOrignalImage:icon];
                    if(image == nil){
                        image = [UIImage imageNamed:icon];
                    }
                    [itemButton setImage:[NavUtil setImageSize:iconSize image:image] forState:UIControlStateNormal];
                }
            }else{
                UIImage * image = [UIImage imageNamed:@"back_arrow"];
                [itemButton setImage:image forState:UIControlStateNormal]; 
            }
            
            
            [itemButton sizeToFit];
            if ([NavUtil getNoEmptyString:titleColor]){
                [itemButton setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
            } else {
                [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            if ([NavUtil getNoEmptyString:item.titleFontName]){
                itemButton.titleLabel.font = [UIFont fontWithName:item.titleFontName size:item.titleSize];
            }else{
                itemButton.titleLabel.font = [UIFont systemFontOfSize:item.titleSize];
            }
            [itemButton sizeToFit];
            [barAry addObject:btnItem];
            tag += 1;
        }
    }
    if (isRight){
        topVC.navigationItem.rightBarButtonItems = barAry;
    } else {
        topVC.navigationItem.leftBarButtonItems = barAry;
    }
}

- (void)_navigatorRouter:(NavOpenAppDTO *)dto complete:(void (^)(BOOL))completionHandler {
    
    completionHandler(YES);
}

- (void)_removeHistoryPage:(NavHistoryDTO *)dto complete:(void (^)(BOOL))completionHandler{
    
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    UINavigationController *nav = topVC.navigationController;
    NSMutableArray *tempAry = [@[] mutableCopy];
    for (RecyleWebViewController *item in nav.viewControllers) {
        if([item isKindOfClass:[RecyleWebViewController class]]){
            
            BOOL isFind = NO;
            for (NSString *url in dto.history) {
                NSRange range = [item.loadUrl rangeOfString:url];
                if(range.location != NSNotFound){
                    if(item.loadUrl.length == (range.location + range.length) ||
                       [[item.loadUrl substringWithRange:NSMakeRange(range.location + range.length, 1)] isEqualToString:@"/"] ||
                       [[item.loadUrl substringWithRange:NSMakeRange(range.location + range.length, 1)] isEqualToString:@"?"]){
                        isFind = YES;
                        break;
                    }
                }
            }
            if(isFind){
                continue;
            }
        }
        [tempAry addObject:item];
    }
    nav.viewControllers = tempAry;
    completionHandler(YES);
}
-(void)navigateHidden:(NSDictionary *)data complate:(XEngineCallBack)completionHandler{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:YES animated:YES];
    completionHandler(nil, YES);
}

-(void)navigateShow:(NSDictionary *)data callBlock:(XEngineCallBack)completionHandler{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    [topVC.navigationController setNavigationBarHidden:NO animated:YES];
    completionHandler(nil, YES);
}
@end


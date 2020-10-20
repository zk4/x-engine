//
//  NavSearchBar.m
//  nav
//
//  Created by 吕冬剑 on 2020/9/16.
//  Copyright © 2020 edz. All rights reserved.
//

#import "NavSearchBar.h"
#import "xengine__module_nav.h"
#import "NavUtil.h"
#import "UITapGestureRecognizer+Block.h"
#import <x-engine-module-tools/UIColor+HexString.h>
#import "Unity.h"
#import "RecyleWebViewController.h"
#import "XEngineWebView.h"
#import "JSONToDictionary.h"

@interface NavSearchBar ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, assign) BOOL isInput;
@end

@implementation NavSearchBar

-(void)setSearchModel:(NavSearchBarDTO *)dto{
    
    self.isInput = dto.isInput;
    UISearchBar* searchBar = [[UISearchBar alloc]init];
    
    if(@available(iOS 11.0,*)){
        [searchBar.heightAnchor constraintEqualToConstant:44].active = YES;
    }
    if (dto.becomeFirstResponder) {
        [searchBar becomeFirstResponder];
    }
    
    if ([NavUtil getNoEmptyString:dto.textColor]) {
//        self.backgroundColor = [UIColor colorWithHexString:dto.textColor];
        UIImage * searchBarBg = [NavUtil getImageWithColor:[UIColor colorWithHexString:dto.backgroundColor] andHeight:30.0f];
        [searchBar setBackgroundImage:searchBarBg];
        [searchBar setBackgroundColor:[UIColor clearColor]];
        [searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    }
    
    CGFloat cornerRadius = dto.cornerRadius;

    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.layer.cornerRadius = cornerRadius;
        searchField.layer.masksToBounds = YES;
    }
    
    static UIImage *iconImage;
    if ([NavUtil getNoEmptyString:dto.iconSearch]) {
        iconImage = [NavUtil getOrignalImage:dto.iconSearch];
        NSArray *iconSearchSize = dto.iconSearchSize;
        CGFloat  searchWidth = 15;
        CGFloat  searchHeight = 15;
        if (iconSearchSize && [iconSearchSize isKindOfClass:NSArray.class] && iconSearchSize.count > 1) {
            searchWidth = [iconSearchSize[0] floatValue];
            searchHeight = [iconSearchSize[1] floatValue];
        }
        
        [searchBar setImage:[NavUtil setImageSize:CGSizeMake(searchWidth, searchHeight) image:iconImage] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    
    
    static UIImage *clearImage;
    if ([NavUtil getNoEmptyString:dto.iconClear]) {
        clearImage = [NavUtil getOrignalImage:dto.iconClear];
        NSArray *iconClearSize = dto.iconClearSize;
        CGFloat clearWidth = 15;
        CGFloat clearHeight = 15;
        if (iconClearSize && [iconClearSize isKindOfClass:NSArray.class] && iconClearSize.count > 1) {
            NSString * width = [NSString stringWithFormat:@"%@", iconClearSize[0]];
            NSString * height = [NSString stringWithFormat:@"%@", iconClearSize[1]];
            clearWidth = [width floatValue];
            clearHeight = [height floatValue];
        }
        [searchBar setImage:[NavUtil setImageSize:CGSizeMake(clearWidth, clearHeight) image:clearImage] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];//iconClear
    }
    
    
    if ([NavUtil getNoEmptyString:dto.textColor]) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor colorWithHexString:dto.textColor];//textcolor
        [searchBar setTintColor:[UIColor colorWithHexString:dto.textColor]];
    }
    
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = [UIFont systemFontOfSize:dto.fontSize];
    NSString * placeHolder = @"";
    if ([NavUtil getNoEmptyString:dto.placeHolder]) {
        searchBar.placeholder = dto.placeHolder;
    } else {
        searchBar.placeholder = nil;
    }
    
    NSAttributedString * attrString = [[NSAttributedString alloc]initWithString:placeHolder attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:dto.fontSize],
    }];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setAttributedPlaceholder:attrString];
    
    if (dto.isInput) {
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];//WithTarget:self action:@selector(tapGesture:)];
        [gesture touchActionBlock:^(UITapGestureRecognizer *sender) {
            UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
            if ([topVC isKindOfClass:[RecyleWebViewController class]]){
                RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
                if (dto.__event__){
                    [webVC.webview callHandler:dto.__event__ arguments:@[@(0)] completionHandler:nil];
                } else {
                    [webVC.webview callHandler:@"handlerNavSearchBar" arguments:@[@"0"] completionHandler:nil];
                }
            }
        }];
        if (@available(iOS 13, *)) {
            [searchBar.searchTextField addGestureRecognizer:gesture];
        }else{
            for (UIView *view in searchBar.subviews.lastObject.subviews) {
                if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                    [view addGestureRecognizer:gesture];
                }
            }
        }
    }
    searchBar.delegate = self;
    [self addSubview:searchBar];
    self.searchBar = searchBar;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.searchBar.frame = self.bounds;
}
#pragma mark searchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (self.isInput) {
        return NO;
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    if ([topVC isKindOfClass:RecyleWebViewController.class]){
        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
        NSDictionary *dict = @{
            @"value" : searchBar.text
        };
        [webVC.webview callHandler:@"handlerNavSearchBar" arguments:@[[JSONToDictionary toString: dict]] completionHandler:^(id  _Nullable value) {
        }];
    }
    if ([searchBar isFirstResponder]) {
        [searchBar resignFirstResponder];
    }
}

- (CGSize)intrinsicContentSize{

    return UILayoutFittingExpandedSize;

}

@end

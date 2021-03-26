//
//  XEOneWebViewPoolModel.h
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2021/3/2.
//

#import <Foundation/Foundation.h>
#import "XEngineWebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface XEOneWebViewPoolModel : NSObject

@property (nonatomic, strong) XEngineWebView *webView;

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) long version;
@property (nonatomic, copy) NSString *appRootPath;

@property (nonatomic, copy) NSString *secrect;
@property (nonatomic, assign) BOOL isStrict;
@property (nonatomic, copy) NSArray *whiteList;

-(BOOL)checkHavStr:(NSString *)str withInAry:(NSArray<NSString *> *)ary;

@end

NS_ASSUME_NONNULL_END

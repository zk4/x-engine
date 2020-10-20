//
//  xengine_protocol_UI.h
//  ModuleApp
//
//  Created by zk on 2020/7/28.
//  Copyright © 2020 edz. All rights reserved.
//  TODO： 这个接口类应该由配置文件自动生成，
//  1. 生成 js 调用工程
//  2. 生成 oc protocol
//  3. 生成 java interface
//

#import <Foundation/Foundation.h>

//   不应该写在这，应该专门定义一个包含 typedef 类
typedef void (^XEngineCallBack)(NSString * _Nullable result,BOOL complete);


@protocol xengine_protocol_UI <NSObject>

- (void)showActionSheet:(NSString *_Nullable)jsonString complate:(XEngineCallBack _Nullable )completionHandler;


@end


//
//  EngineManage.h
//  ModuleApp
//
//  Created by 吕冬剑 on 2020/10/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebViewProtocol.h"

@interface EngineManage : NSObject

@property (nonatomic, weak) id<WebViewProtocol> microAppManage;

@end



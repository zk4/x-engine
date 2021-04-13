//
//  JSIOldRouterModule.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSIModule.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSIOldRouterModule : JSIModule
+ (NSString*)SPAUrl2StandardUrl:(NSString*)raw;
+ (NSDictionary*) convertRouter2JSIModel:(NSDictionary*) dict;
@end

NS_ASSUME_NONNULL_END


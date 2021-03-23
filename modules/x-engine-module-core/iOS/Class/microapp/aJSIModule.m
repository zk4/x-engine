//
//  aJSIModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import "aJSIModule.h"
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

@implementation aJSIModule

- (NSString*) JSImoduleId{
    mustOverride();
}
- (int) JSIorder{
    return 0;
}

@end

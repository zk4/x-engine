//
//  XENativeModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "XENativeModule.h"

# ifndef mustOverride
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#endif

@implementation XENativeModule

- (NSString*) moduleId{
    mustOverride();
}
- (int) order{
    return 0;
}
- (void)afterAllNativeModuleInited{}
@end

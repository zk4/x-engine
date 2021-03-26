//
//  aRNModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "JSONModel.h"
#import "aRNModule.h"
#import <objc/message.h>
# ifndef mustOverride
#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#endif
@implementation aRNModule

- (NSString *)moduleId {
    mustOverride();
}
- (int)order {
    return 0;
}
- (void)afterAllRNModuleInited {
}

@end

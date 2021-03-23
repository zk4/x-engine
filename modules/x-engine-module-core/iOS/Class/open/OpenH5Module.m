//
//  OpenH5Module.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 edz. All rights reserved.
//

#import "OpenH5Module.h"
#import "XEngineContext.h"
@implementation OpenH5Module
NATIVE_MODULE(OpenH5Module)
- (NSString*) moduleId{
    return @"com.zkty.module.open.h5";
}
- (int) order{
    return 0;
}

@end

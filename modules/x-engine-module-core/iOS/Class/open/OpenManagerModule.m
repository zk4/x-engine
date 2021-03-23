//
//  OpenManagerModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 edz. All rights reserved.
//

#import "OpenManagerModule.h"
#import "XEngineContext.h"
@implementation OpenManagerModule
NATIVE_MODULE(OpenManagerModule)
- (NSString*) moduleId{
    return @"com.zkty.module.openmanager.h5";
}
- (int) order{
    return 0;
}

@end

//
//  OpenNativeModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OpenNativeModule.h"
#import "XEngineContext.h"




@implementation OpenNativeModule
NATIVE_MODULE(OpenNativeModule)


- (NSString*) moduleId{
    return @"com.zkty.native.open.native";
}
- (int) order{
    return 0;
}

-(NSString*) type{
    return @"native";
}
- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {

    NSLog(@"open native handled!!");
}
@end

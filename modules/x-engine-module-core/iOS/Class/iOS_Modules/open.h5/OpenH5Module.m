//
//  OpenH5Module.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "OpenH5Module.h"
#import "XEngineContext.h"




@implementation OpenH5Module
NATIVE_MODULE(OpenH5Module)


- (NSString*) moduleId{
    return @"com.zkty.native.open.h5";
}
- (int) order{
    return 0;
}

-(NSString*) type{
    return @"h5";
}
- (void)open:(nonnull NSString *)type :(nonnull NSString *)uri :(nonnull NSString *)path :(nonnull NSDictionary *)args :(long)version :(BOOL)isHidden {

        NSLog(@"open h5 handled!!");

}
@end

//
//  JSI_dev.m
//  dev
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_dev.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_dev()
@end

@implementation JSI_dev
JSI_MODULE(JSI_dev)

- (void)afterAllJSIModuleInited {
}

- (void)_log:(NSString *)dto {
    NSLog(@"JSLOG: %@",dto);
}

@end

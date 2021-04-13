//
//  JSI_xxxx.m
//  xxxx
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_xxxx.h"
#import "JSIContext.h"
#import "NativeContext.h"

@interface JSI_xxxx()
@end

@implementation JSI_xxxx
JSI_MODULE(JSI_xxxx)

- (void)afterAllJSIModuleInited {
}

  

- (void)_asyncMethod:(_0_com_zkty_jsi_xxxx_DTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler([NSString stringWithFormat:@"from native hello:%@", dto.name],TRUE);
}

- (NSString *)_syncMethod:(NamedDTO *)dto {
    return [NSString stringWithFormat:@"from native hello:%@", dto.title];
}

@end

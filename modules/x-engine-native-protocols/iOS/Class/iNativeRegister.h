//
//  iNativeRegister.h
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 @protocol iNativeRegister <NSObject>
typedef UIViewController* _Nullable (^NativeVCCreator)(NSString* protocol,NSString* host, NSString* pathname, NSString* fragment, NSDictionary* query, NSDictionary* params, CGRect frame);
// 注册原生路由
- (void) registerNativeRouter:(NSString*) urlPattern nativeVCCreator:(NativeVCCreator) nativeVCCreator;
@end



NS_ASSUME_NONNULL_END

//
//  iDirectManager.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 @protocol iDirectManager <NSObject>

- (void)push: (NSString*) scheme
        host:(nullable NSString*) host
        path:(NSString*) path
        query:(nullable NSDictionary<NSString*,NSString*>*) query
  hideNavbar:(BOOL) hideNavbar;

- (void)back: (NSString*) scheme host:(nullable NSString*) host path:(NSString*) path;

@end

NS_ASSUME_NONNULL_END

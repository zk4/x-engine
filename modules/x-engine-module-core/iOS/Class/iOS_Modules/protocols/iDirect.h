//
//  iDirect.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 @protocol iDirect <NSObject>
-(NSString*) scheme;
- (void)push:
        (NSString*) host
        pathname:(NSString*) pathname
        query:(NSDictionary<NSString*,NSString*>*) query
  hideNavbar:(BOOL) hideNavbar;

- (void)back:(NSString*) host pathname:(NSString*) pathname;

@end

NS_ASSUME_NONNULL_END

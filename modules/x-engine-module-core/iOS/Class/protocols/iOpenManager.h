//
//  iOpenManager.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iOpenManager <NSObject>
-(void)open:(NSString *)type  :(NSString *)uri  :(NSString *)path  :(NSDictionary *)args  :(long)version  :(BOOL)isHidden;
 
@end

NS_ASSUME_NONNULL_END

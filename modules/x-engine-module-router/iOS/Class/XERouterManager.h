//
//  XERouterManage.h
//  x-engine-module-router
//
//  Created by 吕冬剑 on 2020/10/14.
//

#import <Foundation/Foundation.h>



@interface XERouterManager : NSObject

+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path;

@end



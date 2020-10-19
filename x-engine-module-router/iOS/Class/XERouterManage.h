//
//  XERouterManage.h
//  x-engine-module-router
//
//  Created by 吕冬剑 on 2020/10/14.
//

#import <Foundation/Foundation.h>



@interface XERouterManage : NSObject

+(void)routerToTarget:(int)type withUri:(NSString *)uri withPath:(NSString *)path;

@end



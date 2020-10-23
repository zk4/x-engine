//
//  xengine__module_router.m
//  router
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_router.h"
#import <XEngineContext.h>
#import <micros.h>
#import "XERouterManager.h"


@interface __xengine__module_router()
@end

@implementation __xengine__module_router
 
 

-(void)_openTargetRouter:(RouterOpenAppDTO *)dto complete:(void (^)(BOOL))completionHandler {
    [XERouterManager routerToTarget:dto.type withUri:dto.uri withPath:dto.path];
}

@end
 

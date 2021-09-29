//
//  PostApi.m
//  net
//
//  Created by zk on 2021/9/29.
//  Copyright © 2021 zk. All rights reserved.
//

#import "PostApi.h"
#import "GlobalMergeRequestFilter.h"
#import "GlobalConfigFilter.h"
#import "GlobalStatusCodeNot2xxFilter.h"
#import "GlobalJsonFilter.h"
#import "GlobalNoResponseFilter.h"
#import "xengine_jsi_undefined.h"

 
@implementation PostApi
 
- (void) addLocalFilter:(NSMutableURLRequest*) req{
    [req addFilter:[GlobalConfigFilter sharedInstance]];
    [req addFilter:[GlobalStatusCodeNot2xxFilter sharedInstance]];
    [req addFilter:[GlobalNoResponseFilter sharedInstance]];
    [req addFilter:[GlobalMergeRequestFilter sharedInstance]];
    [req addFilter:[GlobalJsonFilter sharedInstance]];
}
@end

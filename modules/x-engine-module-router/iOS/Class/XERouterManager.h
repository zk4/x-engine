//
//  XERouterManage.h
//  x-engine-module-router
//
//  Created by 吕冬剑 on 2020/10/14.
//

#import <Foundation/Foundation.h>

@protocol XERouterPreDelegate <NSObject>

-(BOOL)preIsRouterToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version withHiddenNavbar:(BOOL)isHidden;

@end

@interface XERouterManager : NSObject

@property (nonatomic, weak) id<XERouterPreDelegate>delegate;

+(instancetype)instance;

-(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version;
-(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version withHiddenNavbar:(BOOL)isHidden;


+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version NS_EXTENSION_UNAVAILABLE_IOS("Use -routerToTarget");
+(void)routerToTarget:(NSString *)type withUri:(NSString *)uri withPath:(NSString *)path withArgs:(NSDictionary *)args withVersion:(long)version withHiddenNavbar:(BOOL)isHidden NS_EXTENSION_UNAVAILABLE_IOS("Use -routerToTarget");
@end

//
//  NSObject+CacheLocalized.h
//  XEngine


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CacheLocalized)
// 获取Caches目录路径
- (NSString *)cachesDirectory;
+ (NSString *)cachesDirectory;

// 获取Preferences目录路径
- (NSString *)microAppDirectory;
+ (NSString *)microAppDirectory;
@end

NS_ASSUME_NONNULL_END

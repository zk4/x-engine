//
//  NSObject+CacheLocalized.m
//  XEngine


#import "NSObject+CacheLocalized.h"

@implementation NSObject (CacheLocalized)
- (NSString *)cachesDirectory
{
    return [NSObject cachesDirectory];
}

+ (NSString *)cachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [paths lastObject];
}

- (NSString *)microAppDirectory
{
    return [NSObject microAppDirectory];
}

+ (NSString *)microAppDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [[paths lastObject] stringByAppendingPathComponent:@"microApps"];
}


@end

//
//  JSONToDictionary.h
//  XEngine


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONToDictionary : NSObject
+ (NSDictionary *)toDictionary:(NSString *)jsonString;
+ (NSString *)toString:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

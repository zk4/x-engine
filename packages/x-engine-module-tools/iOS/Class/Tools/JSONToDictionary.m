//
//  JSONToDictionary.m
//  XEngine

#import "JSONToDictionary.h"

@implementation JSONToDictionary
+ (NSDictionary *)toDictionary:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        return param;
    }
    return nil;
    
}

+ (NSString *)toString:(NSDictionary *)dict {
    NSError *parseError =nil;
    if (!dict || (![dict isKindOfClass:NSDictionary.class] && ![dict isKindOfClass:NSArray.class])) return nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
@end

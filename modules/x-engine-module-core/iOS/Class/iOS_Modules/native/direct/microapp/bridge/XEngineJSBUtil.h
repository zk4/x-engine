//
//  XEngineJSBUtil.h
//  XEngineSDK


#import <Foundation/Foundation.h>

enum{
 XEngine_DSB_API_HASNATIVEMETHOD,
 XEngine_DSB_API_CLOSEPAGE,
 XEngine_DSB_API_RETURNVALUE,
 XEngine_DSB_API_DSINIT,
 XEngine_DSB_API_DISABLESAFETYALERTBOX
};

@interface XEngineJSBUtil : NSObject
+ (NSString * _Nullable)objToJsonString:(id  _Nonnull)dict;
+ (id  _Nullable)jsonStringToObject:(NSString * _Nonnull)jsonString;
+(NSString *_Nullable)methodByNameArg:(NSInteger)argNum
                              selName:( NSString * _Nullable)selName class:(Class _Nonnull )class;
+ (NSArray *_Nonnull)parseNamespace: (NSString *_Nonnull) method;
@end



//
//  XEngineCallInfo.h
//  XEngineSDK

#import <Foundation/Foundation.h>



@interface XEngineCallInfo : NSObject
@property (nullable, nonatomic) NSString* method;
@property (nullable, nonatomic) NSNumber* id;
@property (nullable,nonatomic) NSArray * args;
@end



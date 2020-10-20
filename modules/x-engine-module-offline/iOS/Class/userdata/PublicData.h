//
//  PublicData.h


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface PublicData : NSObject
+ (instancetype)sharedInstance;
@end

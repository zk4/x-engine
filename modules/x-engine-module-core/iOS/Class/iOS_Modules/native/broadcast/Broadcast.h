//
//  Broadcast.h



#import <UIKit/UIKit.h>
#import "NativeModule.h"

@interface Broadcast : NativeModule
+ (void)broadcast:(NSString*) payload;
@end

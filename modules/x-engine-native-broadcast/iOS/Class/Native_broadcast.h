//
//  Native_broadcast.h
//  broadcast
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NativeModule.h"

NS_ASSUME_NONNULL_BEGIN
@interface Native_broadcast : NativeModule
- (void)broadcast:(NSString*) payload;
@end

NS_ASSUME_NONNULL_END

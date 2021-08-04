//
//  NSCachedURLResponse+Modifier.h
//
//  Created by zk on 2021/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCachedURLResponse (Modifier)
-(NSCachedURLResponse*)responseWithExpirationDuration:(int)duration;
-(NSCachedURLResponse*)cors:(NSString*) origin;
@end

NS_ASSUME_NONNULL_END

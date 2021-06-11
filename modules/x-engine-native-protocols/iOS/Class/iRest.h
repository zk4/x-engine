//
//  Native_rest.h
//  rest
//
//  Copyright © 2020 @zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;

@protocol iRest
- (AFHTTPSessionManager *)session:(NSURL *)baseUrl;
@end

NS_ASSUME_NONNULL_END

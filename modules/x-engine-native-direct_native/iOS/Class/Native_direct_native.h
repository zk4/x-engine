//
//  Native_direct_native.h
//  direct_native
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import "iDirect.h"
#import "iNativeRegister.h"

NS_ASSUME_NONNULL_BEGIN
@interface Native_direct_native : XENativeModule  <iDirect,iNativeRegister>


@end

NS_ASSUME_NONNULL_END

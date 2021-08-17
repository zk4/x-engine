//
//  Native_updator.h
//  updator
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import "iUpdator.h"
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@protocol MicroappInfoDTO;
@class MicroappInfoDTO;

@interface MicroappInfoDTO: JSONModel
@property (nonatomic, strong) NSString* localpath;
@property (nonatomic, strong) NSString* microappId;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSDictionary* rawMicroappInfo;
@property (atomic, assign) BOOL locking;
@end
    

@interface Native_updator : XENativeModule <iUpdator>
 
@end

NS_ASSUME_NONNULL_END

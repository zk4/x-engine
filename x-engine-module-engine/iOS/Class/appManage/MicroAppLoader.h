//
//  MicroAppLoader.h
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MicroAppLoader : NSObject

@property (nonatomic, copy) NSString *nowMicroAppId;

+ (instancetype)sharedInstance;
- (NSString*) locateMicroAppByMicroappId:(NSString*)microappId out_version:(long*) version;

@end

NS_ASSUME_NONNULL_END

//
//  MicroAppLoader.h
//  AFNetworking
//
//  Created by zk on 2020/8/27.
//

#import <Foundation/Foundation.h>
@class webviewModel;
NS_ASSUME_NONNULL_BEGIN

@interface MicroAppLoader : NSObject

@property (nonatomic, copy) NSString *nowMicroAppId;
@property (nonatomic, assign) long nowMicroAppVersion;
@property (nonatomic, strong) webviewModel * netmodel;
+ (instancetype)sharedInstance;
+ (NSString *)microappDirectory;

- (BOOL)checkMicroAppVersion:(NSString *)microappId version:(long)version;
- (NSString*) locateMicroAppByMicroappId:(NSString*)microappId in_version:(long) in_version;
-(NSDictionary *)getMicroAppJsonToDictionary:(NSString *)microappId version:(long)version;
@end

NS_ASSUME_NONNULL_END

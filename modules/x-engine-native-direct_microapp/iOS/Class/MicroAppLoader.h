//
//  MicroAppLoader.h
//
//  Created by zk on 2020/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MicroAppLoader : NSObject

+ (instancetype) sharedInstance;
-(NSString *)getMicroAppHost:(NSString *)microAppId withVersion:(int)version;
- (NSString *)microappDirectory;
@end

NS_ASSUME_NONNULL_END

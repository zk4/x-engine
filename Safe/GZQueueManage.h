//
//  ZKQueueManage.h
//  ZKHome
//
//  Created by 吕冬剑 on 2020/10/15.

#import <Foundation/Foundation.h>

typedef void(^QueueActionBlock)(void);

@interface GZQueueManage : NSObject


+(instancetype)instance;

- (NSNumber *)addLastQueue:(QueueActionBlock)queue;
- (NSNumber *)insertFirstQueue:(QueueActionBlock)queue;
- (void)removeActionWithNumber:(NSNumber *)number;
@end



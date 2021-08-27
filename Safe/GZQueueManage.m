//
//  ZKQueueManage.m
//  ZKHome
//
//  Created by 吕冬剑 on 2020/10/15.
//

#import "GZQueueManage.h"

static NSString *const BLOCK_KEY = @"BLOCK_KEY";
static NSString *const NUMBER_KEY = @"NUMBER_KEY";

@interface GZQueueManage ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) dispatch_queue_t actionQueue;
@property (nonatomic, strong) NSMutableArray *list;

@end
@implementation GZQueueManage

+(instancetype)instance{
    static dispatch_once_t onceToken;
    static GZQueueManage *manage;
    dispatch_once(&onceToken, ^{
        manage = [[GZQueueManage alloc] init];
    });
    return manage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.list = [@[] mutableCopy];
        
        self.queue = dispatch_queue_create("ZKQueueManage", DISPATCH_QUEUE_SERIAL);
        self.actionQueue = dispatch_queue_create("ZKQueueManage", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(NSNumber *)addLastQueue:(QueueActionBlock)queue{
    
    __block NSNumber *rNumber = @(0);
    if(queue){
        __weak typeof(self) weakSelf = self;
        QueueActionBlock block = ^(){
            queue();
            [weakSelf doNextAction];
        };
        __block BOOL isAction = false;
        dispatch_sync(self.queue, ^{
            rNumber = @([[NSDate date] timeIntervalSince1970]);
            __strong GZQueueManage *strongSelf = weakSelf;
            if(strongSelf){
                [strongSelf.list addObject:@{
                    BLOCK_KEY:block,
                    NUMBER_KEY:rNumber,
                }];
                isAction = (strongSelf.list.count == 1);
            }
            
        });
        if(isAction){
            [self doAction];
        }
    }
    return rNumber;
}

-(NSNumber *)insertFirstQueue:(QueueActionBlock)queue{

    __block NSNumber *rNumber = @(0);
    if(queue){
        __weak typeof(self) weakSelf = self;
        QueueActionBlock block = ^(){
            queue();
            [weakSelf doNextAction];
        };
        __block BOOL isAction = false;
        dispatch_sync(self.queue, ^{
            rNumber = @([[NSDate date] timeIntervalSince1970]);
            __strong GZQueueManage *strongSelf = weakSelf;
            if(strongSelf){
                [strongSelf.list insertObject:@{
                    BLOCK_KEY:block,
                    NUMBER_KEY:rNumber,
                }
                                      atIndex:(strongSelf.list.count > 0 ? 1 : 0)];
                isAction = (strongSelf.list.count == 1);
            }
        });
        if(isAction){
            [self doAction];
        }
    }
    return rNumber;
}

-(void)doNextAction{
    if(self.list.count > 0){
        [self.list removeObjectAtIndex:0];
        [self doAction];
    }
}

-(void)doAction{
    if(self.list.count > 0){
        NSDictionary *item = self.list[0];
        QueueActionBlock block = item[BLOCK_KEY];
        dispatch_async(self.actionQueue, ^{
            block();
        });
    }
}

- (void)removeActionWithNumber:(NSNumber *)number{
    __weak typeof(self) weakSelf = self;
    dispatch_sync(self.queue, ^{
        __strong GZQueueManage *strongSelf = weakSelf;
        if(strongSelf){
            NSInteger index = 0;
            for (NSDictionary *dic in strongSelf.list){
                if(dic[NUMBER_KEY] == number){
                    [strongSelf.list removeObjectAtIndex:index];
                    break;
                }
                index++;
            }
        }
    });
}

@end

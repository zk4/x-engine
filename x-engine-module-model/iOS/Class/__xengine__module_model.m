//
//  __xengine__module_model.m
//  model
//
//  Created by 李宫 on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "__xengine__module_model.h"
#import "xengine__module_model.h"
#import <micros.h>
#import "ZKTYModel.h"

@interface __xengine__module_model ()
@property (nonatomic,strong)xengine__module_model * proxy;
@end
@implementation __xengine__module_model

-(instancetype)init{
    self = [super init];
    self.proxy = [xengine__module_model new];
    return self;
}
- (NSString *)moduleId{
    return @"com.zkty.module.model";
}

- (void)showActionSheet:(NSDictionary *)param complate:(XEngineCallBack)completionHandler{
    ZKTYModel * dto = [self getDtofromParam:param clazz:[ZKTYModel class]] ;
    if (dto)
        [self.proxy showActionSheet:dto complate:completionHandler];
}

-(id)getDtofromParam:(NSDictionary *)param clazz:(Class)clazz{
    NSError * err;
    id dto = [clazz class];
    dto = [[dto alloc]initWithDictionary:param error:&err];
    if (err) {
        #ifdef DEBUG
        NSArray * errArr = err.userInfo[@"kJSONModelMissingKeys"];
        NSString * errStr = [NSString stringWithFormat:@"%@",errArr[0]];
        if (errArr.count >1) {
            for (int i =1; i<errArr.count; i++) {
                errStr = [errStr stringByAppendingFormat:@"、%@",errArr[i]];
            }
        }
        errStr = [errStr stringByAppendingString:@"参数"];
        [self showErrorAlert:errStr];
        #endif
        return nil;
    }
    return dto;
}
@end

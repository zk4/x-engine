//
//  iStorage.h
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 这个模块不应该依赖本地 h5 id（microapp），这是一个通用原生组件。key 应该在外面传进来时，就已约定好相应关系。
// 可以这样指定 key, 如果是本地 h5（microapp）
// microapp:{id}

@protocol iStorage <NSObject>
    // 返回值
    // 0， key 不存在，value 存储成功
    // 1， key 存在， 存储成功
    // -1， 存储失败
    -(int) save:(NSString *)key value:(NSString *)value;

    -(NSString*) read:(NSString *)key;
@end

NS_ASSUME_NONNULL_END

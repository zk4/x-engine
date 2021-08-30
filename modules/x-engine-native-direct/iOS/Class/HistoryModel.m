//
//  HistoryModel.m
//  ModuleApp
//
//  Created by zk on 2021/3/27.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

-(NSString*) getKey{
    return [NSString stringWithFormat:@"%@%@",_host?_host:@"",_pathname?_pathname:@""];
}
@end

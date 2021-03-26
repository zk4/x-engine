//
//  XEOneWebViewPoolModel.m
//  x-engine-module-engine
//
//  Created by 吕冬剑 on 2021/3/2.
//

#import "XEOneWebViewPoolModel.h"


@implementation XEOneWebViewPoolModel

-(BOOL)checkHavStr:(NSString *)str withInAry:(NSArray<NSString *> *)ary{
    
    if(self.isStrict){
        if(ary.count > 0){
            NSURLComponents *com = [[NSURLComponents alloc] initWithString:str];
            return [ary containsObject:com.host];
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

@end

//
//  aJSIModule.m
//  ModuleApp
//
//  Created by zk on 2021/3/23.
//  Copyright © 2021 zk. All rights reserved.
//

#import "aJSIModule.h"
#import "JSONModel.h"
#import <objc/message.h>


#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

@implementation aJSIModule

- (NSString*) JSImoduleId{
    mustOverride();
}
- (int) JSIorder{
    return 0;
}
- (void) afterAllJSIModuleInited{
    
}

- (int) order {
    return 0;
}
- (void) onAllModulesInited{
    NSLog(@"onAllModulesInited");
}
 
- (id) convert:(NSDictionary *)param  clazz:(Class)clazz{
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
//      [self showErrorAlert:errStr];
//      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[Unity sharedInstance].topView animated:YES];
//      hud.animationType = MBProgressHUDAnimationFade;
//      hud.mode = MBProgressHUDModeText;
//      hud.label.text = [NSString stringWithFormat:@"%@不能为空",errStr];
//      hud.label.numberOfLines = 0;
//      [hud hideAnimated:YES afterDelay:2.0];
      
      #endif
      return nil;
  }
  return dto;
}

    - (void) callInternalMethod:(NSDictionary*) dict complete:(void (^)(id result,BOOL complete))completionHandler methodname:(NSString*) name argclass:(Class) argclass{
        SEL  sel = NSSelectorFromString([NSString stringWithFormat:@"%@:complete:", name]);
        id(*action)(id,SEL,id,id) = (id(*)(id,SEL,id,id))objc_msgSend;
        if(argclass){
          id dto  = [self convert:dict clazz:argclass];
          if(dto){
             if( [self respondsToSelector:sel] ) {
                     action(self, sel,dto, completionHandler);
             }else{
//                 [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
              }
          }
        }else{
            if( [self respondsToSelector:sel] ) {
                    action(self, sel,nil, completionHandler);
            }else{
//                [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
             }

        }
}
  
-(BOOL) isDictionary:(id)item{
    return [item isKindOfClass:NSDictionary.class] || [item isKindOfClass:NSMutableDictionary.class];
}

-(void) assign:(NSMutableDictionary*)to from:(NSMutableDictionary*) from{
    [to addEntriesFromDictionary:from];
}

-(void) _mergeDeep:(NSMutableDictionary*) target  sources:(NSMutableArray*) sources {
  if (!target || !sources || sources.count==0) return;
    NSMutableDictionary* source = [sources lastObject];
    [sources removeLastObject];
    if ([self isDictionary:target] && [self isDictionary:source]) {
    for (NSString* key in source) {
        if ([self isDictionary:[source objectForKey:key]]) {
          if (!target[key]) [self assign:target from:[@{key:@{}} mutableCopy]];
          [self _mergeDeep:target[key] sources:[@[source[key]] mutableCopy]];
      } else {
          [self assign: target  from:[@{key:[source objectForKey:key]} mutableCopy]];
      }
    }
  }

    [self _mergeDeep:target sources:sources];
}

- (NSString *)objToJsonString:(id)object
{
    
    if([object respondsToSelector:@selector(toJSONString)]){
        return [object toJSONString];
    }
  
    NSString *jsonString = nil;
    NSError *error;
    
    if (![NSJSONSerialization isValidJSONObject:object]) {
        return @"{}";
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (id )jsonStringToObject:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



-(void) mergeDeep:(NSMutableDictionary*) target source:(NSMutableDictionary*) source {
    if(!source || !target) return;
    [self _mergeDeep:target sources:[@[source] mutableCopy] ];
}
 
-(NSDictionary*) mergeDefault:(NSDictionary*)dict defaultString:(NSString*)defaultString{
    if(!defaultString || defaultString.length==0) return dict;
    
    NSDictionary* parsed_dict= [self jsonStringToObject:defaultString];
    if(!parsed_dict) return dict;
    
    NSMutableDictionary* merged_dict=[[NSMutableDictionary alloc]initWithDictionary:parsed_dict];
    NSMutableDictionary* mutalbeUserDict=[[NSMutableDictionary alloc]initWithDictionary:dict];
    [self mergeDeep:merged_dict source:mutalbeUserDict];
    return merged_dict;
}


@end

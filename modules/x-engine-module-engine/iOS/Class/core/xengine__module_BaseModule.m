#import "xengine__module_BaseModule.h"
#import "Unity.h"
#import "JSONModel.h"
#import <objc/message.h>
#import "RecyleWebViewController.h"
#import "XEngineWebView.h"
#import <MBProgressHUD.h>
#import "XEngineJSBUtil.h"
#import <Unity.h>

@implementation xengine__module_BaseModule

- (NSString *)moduleId {
    return @"";
}

#pragma mark - fun
- (void)showErrorAlert:(NSString *)errorString
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@不能为空",errorString] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
}

- (BOOL)checkRequiredParam:(id)obj name:(NSString *)name
{
    if (!obj)
    {
        [self showErrorAlert:name];
        return NO;
    }
    if ([obj isKindOfClass:NSString.class])
    {
        NSString *string = (NSString *)obj;
        if (string && ![string isEqualToString:@""]) {
            return YES;
        } else {
            [self showErrorAlert:name];
            return NO;
        }
    } else if([obj isKindOfClass:NSArray.class]) {

        NSArray *array = (NSArray *)obj;
        if (array && array.count != 0)
        {
            return YES;
        } else
        {
            [self showErrorAlert:name];
            return NO;
        }
    }
    return NO;
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
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[Unity sharedInstance].topView animated:YES];
      hud.animationType = MBProgressHUDAnimationFade;
      hud.mode = MBProgressHUDModeText;
      hud.label.text = [NSString stringWithFormat:@"%@不能为空",errStr];
      hud.label.numberOfLines = 0;
      [hud hideAnimated:YES afterDelay:2.0];
      
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
                 [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
              }
          }
        }else{
            if( [self respondsToSelector:sel] ) {
                    action(self, sel,nil, completionHandler);
            }else{
                [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
             }

        }
}
 
- (void) callJS:(NSString*)__event__ args:(id)args retCB:(void (^)(id  _Nullable ret)) retCB{
    [[RecyleWebViewController webview] callHandler:__event__ arguments:args completionHandler:^(id  _Nullable value) {
        retCB(value);
    }];
}
-(void) broadcast:(NSArray*)args{
    [self callJS:@"com.zkty.module.engine.broadcast" args:args retCB:^(id  _Nullable ret) {}];
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
-(void) mergeDeep:(NSMutableDictionary*) target source:(NSMutableDictionary*) source {
    if(!source || !target) return;
    [self _mergeDeep:target sources:[@[source] mutableCopy] ];
}
 
-(NSDictionary*) mergeDefault:(NSDictionary*)dict defaultString:(NSString*)defaultString{
    if(!defaultString || defaultString.length==0) return dict;
    
    NSDictionary* parsed_dict= [XEngineJSBUtil jsonStringToObject:defaultString];
    if(!parsed_dict) return dict;
    
    NSMutableDictionary* merged_dict=[[NSMutableDictionary alloc]initWithDictionary:parsed_dict];
    NSMutableDictionary* mutalbeUserDict=[[NSMutableDictionary alloc]initWithDictionary:dict];
    [self mergeDeep:merged_dict source:mutalbeUserDict];
    return merged_dict;
}

@end

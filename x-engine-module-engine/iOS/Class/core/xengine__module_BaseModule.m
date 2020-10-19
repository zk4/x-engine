//
//  __xengine__module_BaseModule.m
//  UIModule

#import "xengine__module_BaseModule.h"
#import "Unity.h"
//#import "UIViewController+.h"
#import "JSONModel.h"
#import <objc/message.h>
//#import "RecyleWebViewController.h"
#import "XEngineWebView.h"

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
    
//    [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"" message: sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
//                   }];
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
- (void) onAllMoudlesInited{
    NSLog(@"onAllMoudlesInited");
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
      [self showErrorAlert:errStr];
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
//               [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"" message: sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {}];
             }
          }
        }else{
            if( [self respondsToSelector:sel] ) {
                    action(self, sel,nil, completionHandler);
            }else{
                [self showErrorAlert:[NSString stringWithFormat:@"%@.%@ 未实现",[self moduleId],[NSString stringWithFormat:@"%@:", name]]];
//              [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"" message: sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {}];
            }

        }
}
//- (void) callJsByFuncName:event arguments:(NSArray*)arguments completionHandler:(void (^)(id  _Nullable value)) completionHandler{
//    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
//    RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
//    [webVC.webview callHandler:event arguments:arguments completionHandler:completionHandler];
// }

@end

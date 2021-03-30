
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_xxxx.h"


@implementation SheetDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	if ([propertyName isEqualToString:@"itemList"]) { return YES; }
   	if ([propertyName isEqualToString:@"content"]) { return YES; }
   	return NO;
    }
@end
    
  
@implementation ContinousDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"__event__"]) { return YES; }	return NO;
    }
@end
    
  
@implementation MsgPayloadDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	if ([propertyName isEqualToString:@"args"]) { return YES; }
   	if ([propertyName isEqualToString:@"sender"]) { return YES; }
   	if ([propertyName isEqualToString:@"receiver"]) { return YES; }
   
   	return NO;
    }
@end
    




  @implementation xengine_jsi_xxxx
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.xxxx";
    }
    
    - (void) broadcastOn:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _broadcastOn:^(BOOL complete) {
                 completionHandler(nil,complete); 
          }];
      }
    - (void) broadcastOff:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _broadcastOff:^(BOOL complete) {
                 completionHandler(nil,complete); 
          }];
      }
    - (void) triggerNativeBroadCast:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _triggerNativeBroadCast:^(BOOL complete) {
                 completionHandler(nil,complete); 
          }];
      }
    - (void) repeatReturn__event__:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          ContinousDTO* dto = [self convert:dict clazz:ContinousDTO.class];
          [self _repeatReturn__event__:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
    - (void) repeatReturn__ret__:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          ContinousDTO* dto = [self convert:dict clazz:ContinousDTO.class];
          [self _repeatReturn__ret__:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
    - (void) ReturnInPromiseThen:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          ContinousDTO* dto = [self convert:dict clazz:ContinousDTO.class];
          [self _ReturnInPromiseThen:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
  @end

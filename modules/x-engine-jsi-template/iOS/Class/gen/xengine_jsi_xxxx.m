
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_xxxx.h"


@implementation NamedDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation _0_com_zkty_jsi_xxxx_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation _1_com_zkty_jsi_xxxx_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	return NO;
    }
@end
    
  
@implementation _2_com_zkty_jsi_xxxx_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation _3_com_zkty_jsi_xxxx_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
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
    
    - (void) simpleMethod:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _simpleMethod:^(BOOL complete) {
                 completionHandler(nil,complete); 
          }];
      }
  - (id) simpleMethod:(NSDictionary*) dict {
   [self _simpleMethod];
              return nil;
    }
    - (void) simpleArgMethod:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          NSString* dto = [self convert:dict clazz:NSString.class];
          [self _simpleArgMethod:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
  - (NSString*) simpleArgMethod:(NSDictionary*) dict {
      NSString* dto = [self convert:dict clazz:NSString.class];
      return [self _simpleArgMethod:dto];
        }
    - (void) nestedAnonymousObject:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _nestedAnonymousObject:^(_0_com_zkty_jsi_xxxx_DTO* result, BOOL complete) {
            completionHandler(result ,complete);
          }];
      }
  - (_0_com_zkty_jsi_xxxx_DTO*) nestedAnonymousObject:(NSDictionary*) dict {
  return [self _nestedAnonymousObject];
    }
    - (void) namedObject:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          [self _namedObject:^(NamedDTO* result, BOOL complete) {
            completionHandler(result ,complete);
          }];
      }
  - (NamedDTO*) namedObject:(NSDictionary*) dict {
  return [self _namedObject];
    }
    - (void) namedObjectWithNamedArgs:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          NamedDTO* dto = [self convert:dict clazz:NamedDTO.class];
          [self _namedObjectWithNamedArgs:dto complete:^(NamedDTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
  - (NamedDTO*) namedObjectWithNamedArgs:(NSDictionary*) dict {
      NamedDTO* dto = [self convert:dict clazz:NamedDTO.class];
      return [self _namedObjectWithNamedArgs:dto];
        }
    - (void) namedObjectWithArgs:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _3_com_zkty_jsi_xxxx_DTO* dto = [self convert:dict clazz:_3_com_zkty_jsi_xxxx_DTO.class];
          [self _namedObjectWithArgs:dto complete:^(_2_com_zkty_jsi_xxxx_DTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
  - (_2_com_zkty_jsi_xxxx_DTO*) namedObjectWithArgs:(NSDictionary*) dict {
      _3_com_zkty_jsi_xxxx_DTO* dto = [self convert:dict clazz:_3_com_zkty_jsi_xxxx_DTO.class];
      return [self _namedObjectWithArgs:dto];
        }
  @end


// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_store.h"


@implementation ZKStoreEntryDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation _0_com_zkty_jsi_store_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	return NO;
    }
@end
    




  @implementation xengine_jsi_store
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.store";
    }
    
    - (void) get:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          _0_com_zkty_jsi_store_DTO* dto = [self convert:dict clazz:_0_com_zkty_jsi_store_DTO.class];
          [self _get:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
  - (NSString*) get:(NSDictionary*) dict {
      _0_com_zkty_jsi_store_DTO* dto = [self convert:dict clazz:_0_com_zkty_jsi_store_DTO.class];
      return [self _get:dto];
        }
    - (void) set:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          ZKStoreEntryDTO* dto = [self convert:dict clazz:ZKStoreEntryDTO.class];
          [self _set:dto complete:^(BOOL complete) {
             completionHandler(nil ,complete);
          }];
      }
  - (id) set:(NSDictionary*) dict {
      ZKStoreEntryDTO* dto = [self convert:dict clazz:ZKStoreEntryDTO.class];
      [self _set:dto];
                 return nil;
        }
  @end

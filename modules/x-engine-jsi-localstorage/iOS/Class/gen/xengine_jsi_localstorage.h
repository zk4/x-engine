
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol _set_com_zkty_jsi_localstorage_0_DTO;
@class _set_com_zkty_jsi_localstorage_0_DTO;

@interface _set_com_zkty_jsi_localstorage_0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* key;
   	@property(nonatomic,copy) NSString* val;
@end



@protocol xengine_jsi_localstorage_protocol
   @required 
    - (NSString*) _get:(NSString*)dto;

   @required 
    - (void) _set:(_set_com_zkty_jsi_localstorage_0_DTO*)dto;

@end



@interface xengine_jsi_localstorage : JSIModule<xengine_jsi_localstorage_protocol>
@end


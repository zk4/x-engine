
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol ZKStoreEntryDTO;
@protocol _0_com_zkty_jsi_store_DTO;
@class ZKStoreEntryDTO;
@class _0_com_zkty_jsi_store_DTO;

@interface ZKStoreEntryDTO: JSONModel
  	@property(nonatomic,copy) NSString* key;
   	@property(nonatomic,copy) NSString* val;
@end
    

@interface _0_com_zkty_jsi_store_DTO: JSONModel
  	@property(nonatomic,copy) NSString* key;
@end
    


@protocol xengine_jsi_store_protocol
       @required 
        - (void) _get:(_0_com_zkty_jsi_store_DTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;
   @required 
       - (NSString*) _get:(_0_com_zkty_jsi_store_DTO*)dto;
    
      @required 
        - (void) _set:(ZKStoreEntryDTO*) dto complete:(void (^)(BOOL complete)) completionHandler;
       @required 
       - (void) _set:(ZKStoreEntryDTO*)dto;
    
@end
  


@interface xengine_jsi_store : JSIModule<xengine_jsi_store_protocol>
@end



// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol NamedDTO;
@protocol _0_com_zkty_jsi_xxxx_DTO;
@protocol _1_com_zkty_jsi_xxxx_DTO;
@protocol _2_com_zkty_jsi_xxxx_DTO;
@protocol _3_com_zkty_jsi_xxxx_DTO;
@class NamedDTO;
@class _0_com_zkty_jsi_xxxx_DTO;
@class _1_com_zkty_jsi_xxxx_DTO;
@class _2_com_zkty_jsi_xxxx_DTO;
@class _3_com_zkty_jsi_xxxx_DTO;

@interface NamedDTO: JSONModel
  	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,assign) NSInteger titleSize;
@end
    

@interface _0_com_zkty_jsi_xxxx_DTO: JSONModel
  	@property(nonatomic,copy) NSString* a;
   	@property(nonatomic,strong) _1_com_zkty_jsi_xxxx_DTO* i;
@end
    

@interface _1_com_zkty_jsi_xxxx_DTO: JSONModel
  	@property(nonatomic,copy) NSString* n1;
@end
    

@interface _2_com_zkty_jsi_xxxx_DTO: JSONModel
  	@property(nonatomic,copy) NSString* goodname;
   	@property(nonatomic,assign) NSInteger price;
@end
    

@interface _3_com_zkty_jsi_xxxx_DTO: JSONModel
  	@property(nonatomic,copy) NSString* name;
   	@property(nonatomic,assign) NSInteger age;
@end
    


@protocol xengine_jsi_xxxx_protocol
       @required 
       - (void) _simpleMethod:(void (^)(BOOL complete)) completionHandler;
       @required 
       - (void) _simpleMethod;
    
      @required 
        - (void) _simpleArgMethod:(NSString*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;
   @required 
       - (NSString*) _simpleArgMethod:(NSString*)dto;
    
      @required 
        - (void) _simpleArgNumberMethod:(NSInteger) dto complete:(void (^)(NSInteger result,BOOL complete)) completionHandler;
   @required 
       - (NSInteger) _simpleArgNumberMethod:(NSInteger)dto;
    
      @required 
        - (void) _nestedAnonymousObject:(void (^)(_0_com_zkty_jsi_xxxx_DTO* result,BOOL complete)) completionHandler;
       @required 
       - (_0_com_zkty_jsi_xxxx_DTO*) _nestedAnonymousObject;
    
      @required 
        - (void) _namedObject:(void (^)(NamedDTO* result,BOOL complete)) completionHandler;
       @required 
       - (NamedDTO*) _namedObject;
    
      @required 
        - (void) _namedObjectWithNamedArgs:(NamedDTO*) dto complete:(void (^)(NamedDTO* result,BOOL complete)) completionHandler;
   @required 
       - (NamedDTO*) _namedObjectWithNamedArgs:(NamedDTO*)dto;
    
      @required 
        - (void) _namedObjectWithArgs:(_3_com_zkty_jsi_xxxx_DTO*) dto complete:(void (^)(_2_com_zkty_jsi_xxxx_DTO* result,BOOL complete)) completionHandler;
   @required 
       - (_2_com_zkty_jsi_xxxx_DTO*) _namedObjectWithArgs:(_3_com_zkty_jsi_xxxx_DTO*)dto;
    
@end
  


@interface xengine_jsi_xxxx : JSIModule<xengine_jsi_xxxx_protocol>
@end


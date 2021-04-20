
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol SheetDTO;
@protocol ContinousDTO;
@protocol MsgPayloadDTO;
@class SheetDTO;
@class ContinousDTO;
@class MsgPayloadDTO;

@interface SheetDTO: JSONModel
  	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,strong) NSArray<NSString*>* itemList;
   	@property(nonatomic,copy) NSString* content;
   	@property(nonatomic,strong) NSString* __event__;
@end
    

@interface ContinousDTO: JSONModel
  	@property(nonatomic,strong) NSString* __event__;
@end
    

@interface MsgPayloadDTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
   	@property(nonatomic,copy) NSString* sender;
   	@property(nonatomic,strong) NSArray<NSString*>* receiver;
   	@property(nonatomic,strong) NSString* __event__;
   	@property(nonatomic,strong) NSString* __ret__;
@end
    


@protocol xengine_jsi_legacy_protocol
       @required 
       - (void) _broadcastOn:(void (^)(BOOL complete)) completionHandler;
    
      @required 
       - (void) _broadcastOff:(void (^)(BOOL complete)) completionHandler;
    
      @required 
       - (void) _triggerNativeBroadCast:(void (^)(BOOL complete)) completionHandler;
    
      @required 
        - (void) _repeatReturn__event__:(ContinousDTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;

      @required 
        - (void) _repeatReturn__ret__:(ContinousDTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;

      @required 
        - (void) _ReturnInPromiseThen:(ContinousDTO*) dto complete:(void (^)(NSString* result,BOOL complete)) completionHandler;

@end
  


@interface xengine_jsi_legacy : JSIModule<xengine_jsi_legacy_protocol>
@end


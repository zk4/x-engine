
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol SheetDTO;

@interface SheetDTO: JSONModel
  	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,strong) NSArray<NSString*>* itemList;
   	@property(nonatomic,copy) NSString* content;
   	@property(nonatomic,strong) NSString* __event__;
@end
    


@protocol xengine__module_lope_protocol
       @required 
       - (void) _openDoor:(void (^)(BOOL complete)) completionHandler;
    
      @required 
       - (void) _customOpenDoor:(void (^)(BOOL complete)) completionHandler;
    
      @required 
       - (void) _lightLift:(void (^)(BOOL complete)) completionHandler;
    
@end
  


@interface xengine__module_lope : xengine__module_BaseModule<xengine__module_lope_protocol>
@end


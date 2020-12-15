
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol ShareReqDTO;
@protocol ShareResDTO;

@interface ShareReqDTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,copy) NSString* desc;
   	@property(nonatomic,copy) NSString* link;
   	@property(nonatomic,copy) NSString* imageurl;
   	@property(nonatomic,copy) NSString* dataurl;
   	@property(nonatomic,copy) NSString* channel;
   	@property(nonatomic,strong) NSString* __event__;
@end
    

@interface ShareResDTO: JSONModel
  	@property(nonatomic,copy) NSString* code;
   	@property(nonatomic,copy) NSString* errStr;
   	@property(nonatomic,copy) NSString* type;
@end
    


@protocol xengine__module_share_protocol
       @required 
        - (void) _share:(ShareReqDTO*) dto complete:(void (^)(ShareResDTO* result,BOOL complete)) completionHandler;

@end
  


@interface xengine__module_share : xengine__module_BaseModule<xengine__module_share_protocol>
@end


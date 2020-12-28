
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol RouterOpenAppDTO;

@interface RouterOpenAppDTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* uri;
   	@property(nonatomic,copy) NSString* path;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* args;
   	@property(nonatomic,assign) NSInteger version;
   	@property(nonatomic,strong) Boolean* hideNavbar;
@end
    


@protocol xengine__module_router_protocol
       @required 
        - (void) _openTargetRouter:(RouterOpenAppDTO*) dto complete:(void (^)(BOOL complete)) completionHandler;
    
@end
  


@interface xengine__module_router : xengine__module_BaseModule<xengine__module_router_protocol>
@end


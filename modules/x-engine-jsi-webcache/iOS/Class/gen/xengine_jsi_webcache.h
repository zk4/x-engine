
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"






@protocol xengine_jsi_webcache_protocol
   @required 
     - (void) _xhrRequest:(NSDictionary*) dto complete:(void (^)(NSDictionary* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_webcache : JSIModule<xengine_jsi_webcache_protocol>
@end



// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol StatusDTO;
@protocol _openFileReader_com_zkty_jsi_viewer_0_DTO;
@class StatusDTO;
@class _openFileReader_com_zkty_jsi_viewer_0_DTO;

@interface StatusDTO: JSONModel
  	@property(nonatomic,copy) NSString* resultMsg;
@end


@interface _openFileReader_com_zkty_jsi_viewer_0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* fileUrl;
   	@property(nonatomic,copy) NSString* fileType;
   	@property(nonatomic,copy) NSString* title;
@end



@protocol xengine_jsi_viewer_protocol
   @required 
     - (void) _openFileReader:(_openFileReader_com_zkty_jsi_viewer_0_DTO*) dto complete:(void (^)(StatusDTO* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_viewer : JSIModule<xengine_jsi_viewer_protocol>
@end


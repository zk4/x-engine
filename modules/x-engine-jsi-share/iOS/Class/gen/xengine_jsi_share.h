
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol ShareDTO;
@protocol ShareTextDTO;
@protocol ShareImgDTO;
@protocol ShareLinkDTO;
@protocol ShareMiniProgramDTO;
@class ShareDTO;
@class ShareTextDTO;
@class ShareImgDTO;
@class ShareLinkDTO;
@class ShareMiniProgramDTO;

@interface ShareDTO: JSONModel
  	@property(nonatomic,copy) NSString* channel;
   	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* info;
@end


@interface ShareTextDTO: JSONModel
  	@property(nonatomic,copy) NSString* text;
@end


@interface ShareImgDTO: JSONModel
  	@property(nonatomic,copy) NSString* imgData;
@end


@interface ShareLinkDTO: JSONModel
  	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,copy) NSString* desc;
   	@property(nonatomic,copy) NSString* imgUrl;
   	@property(nonatomic,copy) NSString* url;
@end


@interface ShareMiniProgramDTO: JSONModel
  	@property(nonatomic,copy) NSString* userName;
   	@property(nonatomic,copy) NSString* path;
   	@property(nonatomic,copy) NSString* link;
   	@property(nonatomic,assign) NSInteger miniProgramType;
   	@property(nonatomic,copy) NSString* title;
   	@property(nonatomic,copy) NSString* desc;
   	@property(nonatomic,copy) NSString* imgUrl;
@end



@protocol xengine_jsi_share_protocol
   @required 
     - (void) _share:(ShareDTO*) dto complete:(void (^)(BOOL complete)) completionHandler;

@end



@interface xengine_jsi_share : JSIModule<xengine_jsi_share_protocol>
@end


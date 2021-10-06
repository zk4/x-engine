
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSONModel.h"

@protocol PostReq;
@protocol PostReq_hello;
@protocol PostReq_hello_helloworld;
@protocol PostRes;
@class PostReq;
@class PostReq_hello;
@class PostReq_hello_helloworld;
@class PostRes;

@interface PostReq: JSONModel
  
	@property(nonatomic,copy) NSString* userId;
   
	@property(nonatomic,assign) NSInteger tid;
   
	@property(nonatomic,copy) NSString* title;
   
	@property(nonatomic,assign) BOOL completed;
   
	@property(nonatomic,copy) NSString* message;
   
	@property(nonatomic,copy) NSString* moreMsg;
   
	@property(nonatomic,copy) NSString* ext;
   
	@property(nonatomic,strong) PostReq_hello* hello;
@end


@interface PostReq_hello: JSONModel
  
	@property(nonatomic,strong) PostReq_hello_helloworld* world;
@end


@interface PostReq_hello_helloworld: JSONModel
  
	@property(nonatomic,copy) NSString* inner;
@end


@interface PostRes: JSONModel
  // 参数
	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* args;
   
	@property(nonatomic,copy) NSString* data;
   
	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* files;
   
	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* form;
   
	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* headers;
   
	@property(nonatomic,strong) NSMutableDictionary<NSString*,NSString*>* json;
   
	@property(nonatomic,copy) NSString* origin;
   
	@property(nonatomic,copy) NSString* url;
@end



  #import <Foundation/Foundation.h>
  #import "x_api_Post.h"
  #import "KOBaseApi.h"
  #import "FBLPromises.h"
  
    
  @interface gen_PostApi : KOBaseApi
  
  @property (nonatomic, strong) PostReq* dtoReq;
  @property (nonatomic, strong) PostRes* dtoRes;
  
  typedef void (^PostApiResponse)( PostRes* _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);
  
  - (void) request:(PostApiResponse) response;

  - (FBLPromise<PostRes *>*) promise;
  - (FBLPromise<PostRes *>*) promise:(PostReq*) dtoReq;

  @end
  

    

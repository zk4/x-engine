
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSONModel.h"

@protocol SimpleReq;
@protocol SimpleRes;
@class SimpleReq;
@class SimpleRes;

@interface SimpleReq: JSONModel
  
	@property(nonatomic,copy) NSString* userId;
@end


@interface SimpleRes: JSONModel
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
  #import "x_api_Simple.h"
  #import "ZKBaseApi.h"
  #import "FBLPromises.h"
  
    
  @interface gen_SimpleApi : ZKBaseApi
  
  @property (nonatomic, strong) SimpleReq* dtoReq;
  @property (nonatomic, strong) SimpleRes* dtoRes;
  
  typedef void (^SimpleApiResponse)( SimpleRes* _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);
  
  - (void) request:(SimpleApiResponse) response;

  - (FBLPromise<SimpleRes *>*) promise;
  - (FBLPromise<SimpleRes *>*) promise:(SimpleReq*) dtoReq;

  @end
  

    

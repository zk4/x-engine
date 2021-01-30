
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol RequestDTO;
@protocol ReponseDTO;
@protocol DownloadRequestDTO;
@protocol DownloadReponseDTO;
@protocol UploadRequestDTO;
@protocol UploadReponseDTO;

@interface RequestDTO: JSONModel
  	@property(nonatomic,copy) NSString* url;
   	@property(nonatomic,copy) NSString* method;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* params;
@end
    

@interface ReponseDTO: JSONModel
  	@property(nonatomic,copy) NSString* data;
   	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) RequestDTO* request;
@end
    

@interface DownloadRequestDTO: JSONModel
  	@property(nonatomic,copy) NSString* url;
   	@property(nonatomic,copy) NSString* method;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* params;
   	@property(nonatomic,copy) NSString* __event__;
   	@property(nonatomic,assign) BOOL isNeedBase64;
@end
    

@interface DownloadReponseDTO: JSONModel
  	@property(nonatomic,copy) NSString* filePath;
   	@property(nonatomic,copy) NSString* base64DataStr;
   	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) DownloadRequestDTO* request;
@end
    

@interface UploadRequestDTO: JSONModel
  	@property(nonatomic,copy) NSString* url;
   	@property(nonatomic,copy) NSString* method;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* params;
   	@property(nonatomic,copy) NSString* filename;
   	@property(nonatomic,copy) NSString* filepath;
   	@property(nonatomic,copy) NSString* fileBaseStr;
   	@property(nonatomic,copy) NSString* __event__;
@end
    

@interface UploadReponseDTO: JSONModel
  	@property(nonatomic,copy) NSString* data;
   	@property(nonatomic,assign) NSInteger status;
   	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* headers;
   	@property(nonatomic,strong) UploadRequestDTO* request;
@end
    


@protocol xengine__module_network_protocol
       @required 
        - (void) _getRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _postRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _deleteRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _headRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _putRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _patchRequest:(RequestDTO*) dto complete:(void (^)(ReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _downloadRequest:(DownloadRequestDTO*) dto complete:(void (^)(DownloadReponseDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _uploadRequest:(UploadRequestDTO*) dto complete:(void (^)(UploadReponseDTO* result,BOOL complete)) completionHandler;

@end
  


@interface xengine__module_network : xengine__module_BaseModule<xengine__module_network_protocol>
@end


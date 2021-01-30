
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol YJBillDTO;
@protocol YJBillRefundDTO;
@protocol YJBillRetDTO;
@protocol YJBillListDTO;
@protocol WalletDTO;

@interface YJBillDTO: JSONModel
  	@property(nonatomic,copy) NSString* businessCstNo;
   	@property(nonatomic,copy) NSString* platMerCstNo;
   	@property(nonatomic,copy) NSString* tradeMerCstNo;
   	@property(nonatomic,copy) NSString* billNo;
   	@property(nonatomic,copy) NSString* appScheme;
   	@property(nonatomic,assign) BOOL payType;
@end
    

@interface YJBillRefundDTO: JSONModel
  	@property(nonatomic,copy) NSString* refundOrderNo;
@end
    

@interface YJBillRetDTO: JSONModel
  	@property(nonatomic,copy) NSString* billRetStatus;
   	@property(nonatomic,copy) NSString* billRetStatusMessage;
   	@property(nonatomic,assign) BOOL isCancel;
@end
    

@interface YJBillListDTO: JSONModel
  	@property(nonatomic,copy) NSString* businessCstNo;
   	@property(nonatomic,copy) NSString* roomNo;
   	@property(nonatomic,copy) NSString* userRoomNo;
   	@property(nonatomic,copy) NSString* appScheme;
   	@property(nonatomic,assign) BOOL payType;
   	@property(nonatomic,copy) NSString* billStatus;
   	@property(nonatomic,copy) NSString* billType;
@end
    

@interface WalletDTO: JSONModel
  	@property(nonatomic,copy) NSString* platMerCstNo;
   	@property(nonatomic,copy) NSString* businessCstName;
   	@property(nonatomic,copy) NSString* businessCstNo;
   	@property(nonatomic,copy) NSString* businessCstMobileNo;
   	@property(nonatomic,copy) NSString* appScheme;
@end
    


@protocol xengine__module_yjzdbill_protocol
       @required 
        - (void) _YJBillPayment:(YJBillDTO*) dto complete:(void (^)(YJBillRetDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _YJBillRefund:(YJBillRefundDTO*) dto complete:(void (^)(YJBillRetDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _YJBillList:(YJBillListDTO*) dto complete:(void (^)(BOOL complete)) completionHandler;
    
      @required 
        - (void) _callWallet:(WalletDTO*) dto complete:(void (^)(BOOL complete)) completionHandler;
    
@end
  


@interface xengine__module_yjzdbill : xengine__module_BaseModule<xengine__module_yjzdbill_protocol>
@end


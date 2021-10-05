
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSONModel.h"

@protocol netdto_charge_feeListReq;
@protocol netdto_charge_feeListRes;
@protocol netdto_charge_feeListRes_records;
@protocol netdto_charge_feeListRes_records_feeScaleList;
@class netdto_charge_feeListReq;
@class netdto_charge_feeListRes;
@class netdto_charge_feeListRes_records;
@class netdto_charge_feeListRes_records_feeScaleList;

@interface netdto_charge_feeListReq: JSONModel
  // 收费项目
	@property(nonatomic,copy) NSString* feeName;
   // 页码
	@property(nonatomic,assign) NSInteger pageNum;
   // 查询条数
	@property(nonatomic,assign) NSInteger pageSize;
   // 门店名称
	@property(nonatomic,copy) NSString* storeName;
@end


@interface netdto_charge_feeListRes: JSONModel
  
	@property(nonatomic,assign) NSInteger current;
   
	@property(nonatomic,copy) NSString* message;
   
	@property(nonatomic,strong) NSMutableArray<netdto_charge_feeListRes_records*><netdto_charge_feeListRes_records>* records;
   
	@property(nonatomic,copy) NSString* status;
   
	@property(nonatomic,assign) BOOL success;
   
	@property(nonatomic,assign) NSInteger total;
@end


@interface netdto_charge_feeListRes_records: JSONModel
  // 是否需要附件：0不需要，1需要
	@property(nonatomic,assign) NSInteger attachmentsRequired;
   // 费项收费周期
	@property(nonatomic,copy) NSString* billCycle;
   // 计收主体Id
	@property(nonatomic,copy) NSString* companyId;
   // 计收主体名
	@property(nonatomic,copy) NSString* companyName;
   // 创建人
	@property(nonatomic,copy) NSString* createPerson;
   // 创建时间
	@property(nonatomic,copy) NSString* createTime;
   // 备注
	@property(nonatomic,copy) NSString* description;
   // 数据有效性标识
	@property(nonatomic,copy) NSString* endTime;
   // 费项编码
	@property(nonatomic,copy) NSString* feeCode;
   // 费项名称
	@property(nonatomic,copy) NSString* feeName;
   // 费项关联的费标数量
	@property(nonatomic,assign) NSInteger feeScaleCount;
   // 费项关联的费标列表
	@property(nonatomic,strong) NSMutableArray<netdto_charge_feeListRes_records_feeScaleList*><netdto_charge_feeListRes_records_feeScaleList>* feeScaleList;
   // 是否需要设置费标
	@property(nonatomic,copy) NSString* feeScaleNecessary;
   // 是否生成账单
	@property(nonatomic,copy) NSString* generateBill;
   // 主键
	@property(nonatomic,copy) NSString* id;
   // 费项删除状态
	@property(nonatomic,assign) NSInteger ifDelete;
   // 是否需要开票
	@property(nonatomic,copy) NSString* invoiceNecessary;
   // 费项被费标引用数
	@property(nonatomic,assign) NSInteger scaleUsedCount;
   // 门店id
	@property(nonatomic,copy) NSString* storeId;
   // 门店名称
	@property(nonatomic,copy) NSString* storeName;
   // 税率编码
	@property(nonatomic,copy) NSString* taxCode;
   // 税率
	@property(nonatomic,copy) NSString* taxRate;
   // 修改人
	@property(nonatomic,copy) NSString* updatePerson;
   // 修改时间
	@property(nonatomic,copy) NSString* updateTime;
   // 用户Id
	@property(nonatomic,copy) NSString* userId;
@end


@interface netdto_charge_feeListRes_records_feeScaleList: JSONModel
  // 费标关联的账单数
	@property(nonatomic,assign) NSInteger billCount;
   // 账单周期
	@property(nonatomic,copy) NSString* billCycle;
   // 费标计费周期
	@property(nonatomic,copy) NSString* chargeCycle;
   // 计费周期方式
	@property(nonatomic,copy) NSString* chargeCycleType;
   // 计费开始月份
	@property(nonatomic,assign) NSInteger chargeStartMonth;
   // 计费方式
	@property(nonatomic,copy) NSString* chargeType;
   // 费标计费单位
	@property(nonatomic,copy) NSString* chargeUnit;
   // 费标计费单价
	@property(nonatomic,strong) NSNumber* chargeUnitPrice;
   // 费标计费比例
	@property(nonatomic,strong) NSNumber* chargeUnitProportion;
   // 费标收费周期
	@property(nonatomic,copy) NSString* chargingCycle;
   // 创建人
	@property(nonatomic,copy) NSString* createPerson;
   // 创建时间
	@property(nonatomic,copy) NSString* createTime;
   // 小数处理方式
	@property(nonatomic,copy) NSString* decimalMode;
   // 保留小数点位数
	@property(nonatomic,assign) NSInteger decimalPlace;
   // 备注
	@property(nonatomic,copy) NSString* description;
   // 数据有效性标识
	@property(nonatomic,copy) NSString* endTime;
   // 费项编码
	@property(nonatomic,copy) NSString* feeCode;
   // 关联费项id
	@property(nonatomic,copy) NSString* feeId;
   // 费项名称
	@property(nonatomic,copy) NSString* feeName;
   // 主键
	@property(nonatomic,copy) NSString* id;
   // 删除状态
	@property(nonatomic,assign) NSInteger ifDelete;
   // 费项标准Id
	@property(nonatomic,copy) NSString* scaleId;
   // 费项标准名称
	@property(nonatomic,copy) NSString* scaleName;
   // 分摊方式
	@property(nonatomic,copy) NSString* shareType;
   // 店铺引用费标数
	@property(nonatomic,assign) NSInteger shopUsedCount;
   // 费项来源
	@property(nonatomic,copy) NSString* sourceApp;
   // 门店ID
	@property(nonatomic,copy) NSString* storeId;
   // 门店名字
	@property(nonatomic,copy) NSString* storeName;
   // 单价方式
	@property(nonatomic,copy) NSString* unitPriceType;
   // 修改人
	@property(nonatomic,copy) NSString* updatePerson;
   // 修改时间
	@property(nonatomic,copy) NSString* updateTime;
   // 用户Id
	@property(nonatomic,copy) NSString* userId;
@end



  #import <Foundation/Foundation.h>
  #import "x_api_charge_feeList.h"
  #import "ZKBaseApi.h"
  #import "FBLPromises.h"
  
    
  @interface gen_charge_feeListApi : ZKBaseApi
  
  @property (nonatomic, strong) netdto_charge_feeListReq* dtoReq;
  @property (nonatomic, strong) netdto_charge_feeListRes* dtoRes;
  
  typedef void (^charge_feeListApiResponse)( netdto_charge_feeListRes* _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error);
  
  - (void) request:(charge_feeListApiResponse) response;

  - (FBLPromise<netdto_charge_feeListRes *>*) promise;
  - (FBLPromise<netdto_charge_feeListRes *>*) promise:(netdto_charge_feeListReq*) dtoReq;

  @end
  

    

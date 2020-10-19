//
//  MicroConfigModel.h
//  XEngine

#import <JSONModel/JSONModel.h>

@protocol ZipModel;

@interface ZipModel : JSONModel
@property (nonatomic,copy) NSString *microAppId; // zipId
@property (nonatomic,copy) NSString *microAppName; //名称
@property (nonatomic,copy) NSString *microAppVersion; // zip包版本
@end

@interface MicroConfigModel : JSONModel
@property (nonatomic,copy) NSString *forceUpdate; // 强制更新
@property (nonatomic,copy) NSString *version; //版本
@property (nonatomic,copy) NSString *code; //
@property (nonatomic,strong) NSArray <ZipModel>*data; // zip包信息
@end


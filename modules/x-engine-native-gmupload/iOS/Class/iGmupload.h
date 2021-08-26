//
//  iGmupload.h
//  Gmupload
//

#ifndef iGmupload_h
#define iGmupload_h
@protocol iGmupload <NSObject>
/// 发送上传请求
/// @param url 地址
/// @param header header
/// @param imageData 图片data
/// @param imageName 图片名称
/// @param success 成功结果
/// @param failure 失败结果
- (void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSDictionary *dict))failure;
@end
#endif /* iGmupload_h */

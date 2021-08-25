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
/// @param result 请求结果
- (void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName completion:(void (^)(NSDictionary *dict))result;
@end
#endif /* iGmupload_h */

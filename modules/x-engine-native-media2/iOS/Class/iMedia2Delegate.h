 
#ifndef iMedia2Delegate_h
#define iMedia2Delegate_h
#import <UIKit/UIKit.h>

@protocol iMedia2Delegate <NSObject>
- (void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSDictionary *dict))failure;
@end
#endif /* iMedia2_h */

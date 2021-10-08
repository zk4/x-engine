//
//  iMediaDelegate.h
//  JSONModel
//
//  Created by cwz on 2021/9/4.
//

#ifndef iMediaDelegate_h
#define iMediaDelegate_h
#import <UIKit/UIKit.h>

@protocol iMediaDelegate <NSObject>
- (void)sendUploadRequestWithUrl:(NSString *)url header:(NSDictionary *)header imageData:(NSData *)imageData imageName:(NSString *)imageName success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSError *error))failure;
@end
#endif

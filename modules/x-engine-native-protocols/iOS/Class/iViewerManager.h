//
//  iViewerManager.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iViewerManager <NSObject>

- (void)openFileWithfileUrl:(NSString *)url fileType:(NSString *)type callBack:(void(^)(NSString *__nullable filepath))callBack;
@end

NS_ASSUME_NONNULL_END

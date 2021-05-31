//
//  iViewerManager.h
//  x-engine-native-protocols
//
//  Created by jabraknight on 2021/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol iViewerManager <NSObject>

- (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END

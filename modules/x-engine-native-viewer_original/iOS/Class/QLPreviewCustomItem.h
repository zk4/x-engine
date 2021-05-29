//
//  QLPreviewCustomItem.h
//  x-engine-native-viewer_original
//
//  Created by jabraknight on 2021/5/28.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLPreviewCustomItem : NSObject<QLPreviewItem>
@property (readonly) NSString* previewItemTitle;
@property (readonly) NSURL *previewItemURL;
- (id) initWithTitle:(NSString*)title url:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END

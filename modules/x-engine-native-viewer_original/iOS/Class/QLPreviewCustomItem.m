//
//  QLPreviewCustomItem.m
//  x-engine-native-viewer_original
//
//  Created by jabraknight on 2021/5/28.
//

#import "QLPreviewCustomItem.h"

@implementation QLPreviewCustomItem
- (id) initWithTitle:(NSString*)title url:(NSURL*)url
{
    self = [super init];
    if (self != nil) {
        _previewItemTitle = title;
        _previewItemURL   = url;
    }
    return self;
}

@end

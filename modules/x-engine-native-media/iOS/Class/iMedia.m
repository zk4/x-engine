//
//  iMedia.m
//  x-engine-native-media
//
//  Created by cwz on 2021/8/18.
//

#import "iMedia.h"

@implementation MediaParamsDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
    if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
    if ([propertyName isEqualToString:@"photoCount"]) { return YES; }
    return NO;
}
@end

@implementation MediaResultDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}
@end

@implementation MediaSaveImageDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"type"]) { return YES; }
    if ([propertyName isEqualToString:@"imageData"]) { return YES; }
    return NO;
}
@end

@implementation MediaPhotoListDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"index"]) { return YES; }
    if ([propertyName isEqualToString:@"imgList"]) { return YES; }
    return NO;
}
@end

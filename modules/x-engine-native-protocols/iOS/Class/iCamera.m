
//
//  icamera.h
//  camera
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#import "iCamera.h"
@implementation CameraParamsDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
    if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
    if ([propertyName isEqualToString:@"photoCount"]) { return YES; }
    return NO;
}
@end

@implementation CameraResultDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}
@end

@implementation SaveImageDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"type"]) { return YES; }
    if ([propertyName isEqualToString:@"imageData"]) { return YES; }
    return NO;
}
@end

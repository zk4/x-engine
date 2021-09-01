#import "iMedia2.h"



@implementation Media2ParamsDTO
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"allowsEditing"]) { return YES; }
    if ([propertyName isEqualToString:@"savePhotosAlbum"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraFlashMode"]) { return YES; }
    if ([propertyName isEqualToString:@"cameraDevice"]) { return YES; }
    if ([propertyName isEqualToString:@"photoCount"]) { return YES; }
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

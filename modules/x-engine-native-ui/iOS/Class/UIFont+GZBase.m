//
//  UIFont+GZBase.m
//  Appc
//
//  Created by 吕冬剑 on 2021/2/1.
//

#import "UIFont+GZBase.h"

@implementation UIFont (GZBase)

+(UIFont *)pingFangSCRegularFont:(float)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}
+(UIFont *)pingFangSCSemiboldFont:(float)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}
+(UIFont *)pingFangSCMediumFont:(float)size{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

@end

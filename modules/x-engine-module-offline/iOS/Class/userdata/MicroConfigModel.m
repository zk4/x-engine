//
//  MicroConfigModel.m
//  XEngine


#import "MicroConfigModel.h"

@implementation ZipModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

#pragma mark － NSSecureCoding
+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder
{
   
    if (self = [super init])
    {
        // NSSecureCoding 解归档时要传数据类名
        _microAppId = [decoder decodeObjectOfClass:[NSString class] forKey:@"microAppId"];
        _microAppName= [decoder decodeObjectOfClass:[NSString class] forKey:@"microAppName"];
        _microAppVersion = [decoder decodeObjectOfClass:[NSString class] forKey:@"microAppVersion"];
  
//        _apnsToken = [decoder decodeObjectOfClass:[NSString class] forKey:@"apnsToken"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_microAppId forKey:@"microAppId"];
    [encoder encodeObject:_microAppName forKey:@"microAppName"];
    [encoder encodeObject:_microAppVersion forKey:@"microAppVersion"];

    
//    [encoder encodeObject:_apnsToken forKey:@"apnsToken"];
    
   
}
@end

@implementation MicroConfigModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

#pragma mark － NSSecureCoding
+ (BOOL)supportsSecureCoding
{
    return YES;
}


- (id)initWithCoder:(NSCoder *)decoder
{
   
    if (self = [super init])
    {
        // NSSecureCoding 解归档时要传数据类名
        _code = [decoder decodeObjectOfClass:[NSString class] forKey:@"code"];
        _version = [decoder decodeObjectOfClass:[NSString class] forKey:@"version"];
        _forceUpdate = [decoder decodeObjectOfClass:[NSString class] forKey:@"forceUpdate"];
        _data = [decoder decodeObjectOfClass:[NSString class] forKey:@"data"];
        
//        _apnsToken = [decoder decodeObjectOfClass:[NSString class] forKey:@"apnsToken"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_code forKey:@"code"];
    [encoder encodeObject:_version forKey:@"version"];
    [encoder encodeObject:_forceUpdate forKey:@"forceUpdate"];

    [encoder encodeObject:_data forKey:@"data"];
    
//    [encoder encodeObject:_apnsToken forKey:@"apnsToken"];
    
   
}
@end

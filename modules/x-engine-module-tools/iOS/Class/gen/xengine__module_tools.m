
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine__module_tools.h"
#import <micros.h>


@implementation XEZipDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	if ([propertyName isEqualToString:@"toZipPath"]) { return YES; }
   	if ([propertyName isEqualToString:@"__event__"]) { return YES; }	return NO;
    }
@end
    
  
@implementation XEUnZipDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	if ([propertyName isEqualToString:@"unZipPath"]) { return YES; }
   	if ([propertyName isEqualToString:@"__event__"]) { return YES; }	return NO;
    }
@end
    
  
@implementation XEInsertDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	return NO;
    }
@end
    




  @implementation xengine__module_tools
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.module.tools";
    }
    
    - (void) unZipFile:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          XEUnZipDTO* dto = [self convert:dict clazz:XEUnZipDTO.class];
          [self _unZipFile:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
    - (void) zipFile:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          XEZipDTO* dto = [self convert:dict clazz:XEZipDTO.class];
          [self _zipFile:dto complete:^(NSString* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }

- (void)_unZipFile:(XEUnZipDTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
}

- (void)_zipFile:(XEZipDTO *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    
}

@end

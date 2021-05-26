//
//  JSI_viewer.m
//  viewer
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "JSI_viewer.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iViewer.h"
@interface JSI_viewer()
@property(nonatomic,strong) id<iViewer> iviewer;

@end

@implementation JSI_viewer
JSI_MODULE(JSI_viewer)

- (void)afterAllJSIModuleInited {
    self.iviewer = XENP(iViewer);

}
  
- (void)_openFileReader:(OpenFiileDTO *)dto complete:(void (^)(StatusDTO *, BOOL))completionHandler {
    dto.filePath 
    [self.iviewer openFileWithfileUrl:dto.filePath fileType:@"pdf" callBack:^(NSString * _Nullable filepath) {
        
    }];
}

@end

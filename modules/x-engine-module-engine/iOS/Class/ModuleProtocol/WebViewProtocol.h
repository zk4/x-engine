//
//  MicroAppProtocol.h
//  ModuleApp
//
//  Created by 吕冬剑 on 2020/10/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol WebViewProtocol <NSObject>

- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments;
- (void)runJsFunction:(NSString *)event arguments:(NSArray *)arguments completionHandler:(void (^)(id value)) completionHandler ;

@end



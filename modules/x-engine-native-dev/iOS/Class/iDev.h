//
//  iDev.h
//  Dev
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iDev_h
#define iDev_h
@protocol iDev <NSObject>
/**
 一种将主工程环境信息传到 lib 里的通用做法，在运行时做。
 */
- (void) log:(NSString*) msg;

/*
 基于主工程　build configuration 的配置，使 lib 里的宏生效
 post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
       if config.name == 'Debug'
         config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) DEBUG=1'
       end
       if config.name == 'Release'
         config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) RELEASE=1'
       end

     end
   end
 end

 */
- (void) xlog:(NSString*) msg;
@end
#endif /* iDev_h */

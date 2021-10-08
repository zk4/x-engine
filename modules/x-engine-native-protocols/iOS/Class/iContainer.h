//
//  iContainer.h
//  Created by zk on 2021/9/17.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

// 逻辑容器抽象类，在 iOS 里应该为 vc。而不是 view
@protocol iContainer <NSObject>
 - (void) onCreated;
 - (void) beforeShow;
 - (void) afterShow;
 - (void) beforeHide;
 - (void) afterHide;
 - (void) beforeDead;
@end

 

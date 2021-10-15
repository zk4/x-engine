//
//  JSI_Direct.h
//  ModuleApp
//
//  Created by zk on 2021/3/14.
//  Copyright © 2021 x-engine. All rights reserved.
//

/*
 ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
 │                                            href                                             │
 ├──────────┬──┬─────────────────────┬─────────────────────┬───────────────────────────┬───────┤
 │ protocol │  │        auth         │        host         │           path            │ hash  │
 │          │  │                     ├──────────────┬──────┼──────────┬────────────────┤       │
 │          │  │                     │   hostname   │ port │ pathname │     search     │       │
 │          │  │                     │              │      │          ├─┬──────────────┤       │
 │          │  │                     │              │      │          │ │    query     │       │
 "  https:   //    user   :   pass   @ sub.host.com : 8080   /p/a/t/h  ?  query=string   #hash "
 │          │  │          │          │   hostname   │ port │          │                │       │
 │          │  │          │          ├──────────────┴──────┤          │                │       │
 │ protocol │  │ username │ password │        host         │          │                │       │
 ├──────────┴──┼──────────┴──────────┼─────────────────────┤          │                │       │
 │   origin    │                     │       origin        │ pathname │     search     │ hash  │
 ├─────────────┴─────────────────────┴─────────────────────┴──────────┴────────────────┴───────┤
 │                                            href                                             │
 └─────────────────────────────────────────────────────────────────────────────────────────────┘
 
 
 */
#import <Foundation/Foundation.h>
#import "JSIModule.h"
#import "xengine_jsi_direct.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSI_direct : xengine_jsi_direct

@end

NS_ASSUME_NONNULL_END


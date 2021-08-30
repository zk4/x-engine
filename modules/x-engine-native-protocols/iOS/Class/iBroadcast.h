//
//  iBroadcast.h
//  Broadcast
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iBroadcast_h
#define iBroadcast_h
@protocol iBroadcast <NSObject>
-(void) broadcast:(NSString*) type payload:(NSString*) payload;
@end
#endif /* iBroadcast_h */

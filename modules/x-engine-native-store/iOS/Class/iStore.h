//
//  istore.h
//  store
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef istore_h
#define istore_h

@protocol iStore <NSObject>
- (id)get:(NSString *)key;
- (void)set:(NSString *)key val:(id)val;
- (void)saveTodisk;
- (void)readFromDisk:(BOOL)merge;
@end
#endif /* istore_h */

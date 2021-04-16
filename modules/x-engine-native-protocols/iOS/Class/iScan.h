//
//  iScan.h
//  Scan
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iScan_h
#define iScan_h
@protocol iScan <NSObject>
- (void)openScanView:(void (^)(NSString * res))completionHandler;
@end
#endif /* iScan_h */

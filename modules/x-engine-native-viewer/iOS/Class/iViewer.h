//
//  iViewer.h
//  Viewer
//
//  Created by zk on 2021/4/3.
//  Copyright © 2021 zk. All rights reserved.
//

#ifndef iViewer_h
#define iViewer_h
@protocol iViewer <NSObject>
///打开方式
@property (nonatomic,assign)BOOL defaultState;
///模块
- (nonnull NSString *)modulName;
///类型
- (nonnull NSArray *)modulTypeList;

- (BOOL)getDefaultState;

- (void)openFileWithfileUrl:(NSString *)url fileType:(NSString *)type callBack:(void(^)(NSString *__nullable filepath))callBack;
@end
#endif /* iViewer_h */

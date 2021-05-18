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
///类型
- (nonnull NSArray *)openFileTypeList;

- (BOOL)getDefaultState;
//
- (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type callBack:(void(^_Nullable)(NSString *__nullable filepath))callBack;
@end
#endif /* iViewer_h */

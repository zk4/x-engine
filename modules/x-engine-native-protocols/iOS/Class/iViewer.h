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
    - (void)setDefault:(BOOL) val;
    - (BOOL) isDefault;
    - (NSArray<NSString*>*_Nullable) getTypes;
    - (NSString*_Nullable) getName;
    - (NSString*_Nullable) getIconUrl;
    - (void)openFileWithfileUrl:(NSString *_Nonnull)url fileType:(NSString *_Nonnull)type title:(NSString *_Nonnull)title;
@end
#endif /* iViewer_h */

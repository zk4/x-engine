//
//  XEUploadDataModel.h
//  network
//
//  Created by 吕冬剑 on 2020/9/24.
//  Copyright © 2020 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XEUploadDataModel : NSObject

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *paramKey;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *mimeType;

@property (nonatomic, copy) NSString *fileBase64Str;

@end

NS_ASSUME_NONNULL_END

//
//  webviewModel.h
//  x-engine-module-engine
//
//  Created by 李宫 on 2021/2/8.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface webviewModel : JSONModel
@property (nonatomic) NSArray *white_host_list;
@property (nonatomic) BOOL strict;

@end

@interface moduleModel : JSONModel
@property (nonatomic) NSDictionary * module;
@end

NS_ASSUME_NONNULL_END

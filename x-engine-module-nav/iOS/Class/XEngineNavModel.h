//
//  XEngineNavModel.h
//  AFNetworking
//
//  Created by edz on 2020/7/24.
//

#import "JSONModel.h"

@interface XEngineNavModel : JSONModel

@property (nonatomic, copy) NSString *title; /** 标题 */
@property (nonatomic, copy) NSString *url; /** 跳转页面地址 */
@property (nonatomic, copy) NSString *param_id; /** id */
@property (nonatomic, copy) NSString *param_target; /**  */


@end



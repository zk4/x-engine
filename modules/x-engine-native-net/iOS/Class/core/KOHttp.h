//
//  KOHttp.h
//  net
//
//  Created by zk on 2021/9/28.
//  Copyright © 2021 x-engine. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE./

#import <Foundation/Foundation.h>
#import "iKONet.h"

NS_ASSUME_NONNULL_BEGIN

@interface KOHttp<reqType,resType>: NSObject <iKONetAgent,iKOFilterChain>

// 配置全局 urlPrefix
+ (void) ko_configGlobalUrlPrefix:(NSString*) urlPrefix;

// 获取全局 urlPrefix
+ (NSString*) ko_getGlobalUrlPrefix;

// 绑定 pipelineName 与 pipeline
// 使用 activePipeline 方法激活
+ (void) ko_configPipelineByName:(NSString*) name pipeline:(KOPipeline) pipeline;

// 获取全局 pipeline 例表
+(NSMutableDictionary<NSString*,NSMutableArray*>*)  ko_globalPipelines;

// 唯一发送函数
// http 报文= headers + body
//         = method + url + other headers  + body
//         = method + url + other headers  + (body with type based on different ContentType)
//                                           根据 ContentType 解析
-(id<iKONetAgent>) send:(NSMutableURLRequest*)reqeust response:(KOResponse) block;

// 增加 filter，注意： filter 有处理顺序
// 按照 1->2->3-> network-agent ->3->2->1 业务的方向
-(id<iKONetAgent>) addFilter:(id<iKOFilter>) filter;

// 激活当前请求的 pipeline
-(id<iKONetAgent>) activePipeline:(KOPipeline) pipeline;

// 通过名字激活 pipeline
- (void) activePipelineByName:(NSString*) name;

// 内部 filter 调用链
-(void) doFilter:(NSURLSession*)session request:(NSMutableURLRequest*) request response:(KOResponse) KOResponse;

@end

NS_ASSUME_NONNULL_END

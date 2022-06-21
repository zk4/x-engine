//
//  JSI_browser.m
//  browser
//
// Copyright (c) 2021 x-engine
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


#import "JSI_browser.h"
#import "JSIContext.h"
#import "XENativeContext.h"

@interface JSI_browser()
@end

@implementation JSI_browser
JSI_MODULE(JSI_browser)

- (void)afterAllJSIModuleInited {
    
}

- (void)_open:(_open_com_zkty_jsi_browser_1_DTO *)dto complete:(void (^)(_open_com_zkty_jsi_browser_0_DTO *, BOOL))completionHandler {
    NSURL *linkUrl = [NSURL URLWithString:dto.url?:@""];
    if ([[UIApplication sharedApplication] canOpenURL:linkUrl]) {
        [[UIApplication sharedApplication]openURL:linkUrl options:@{} completionHandler:^(BOOL success) {
            _open_com_zkty_jsi_browser_0_DTO *backDto = [_open_com_zkty_jsi_browser_0_DTO new];
            backDto.code = 0;
            backDto.msg = @"打开成功";
            if (completionHandler) {
                completionHandler(backDto,TRUE);
            }
        }];
    }else{
        _open_com_zkty_jsi_browser_0_DTO *backDto = [_open_com_zkty_jsi_browser_0_DTO new];
        backDto.code = 1;
        backDto.msg = @"网址无效，请检查后重试";
        if (completionHandler) {
            completionHandler(backDto,FALSE);
        }
    }
}

@end

//
//  ZKLogViewController.m
//  motherboard
//
//  Created by 李宫 on 2020/10/23.
//  Copyright © 2020 zk. All rights reserved.
//

#import "ZKLogViewController.h"
#import "Prefix.h"
@interface ZKLogViewController ()
@property (nonatomic,strong)UITextView * textView;
@end

@implementation ZKLogViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, kNavigationH, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - kNavigationH - kTabBarH)];
        self.textView.editable = NO;
        [self.view addSubview:self.textView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextValueChangedNotificationHandler:) name:@"inputTextValueChangedNotification" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)inputTextValueChangedNotificationHandler:(NSNotification*)notification{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",self.textView.text, notification.userInfo[@"inputText"]];
    NSRange range;
    range.location = [self.textView.text length] - 1;
    range.length = 0;
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    [self.textView scrollRangeToVisible:range];
}


@end

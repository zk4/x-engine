//
//  MainNavigationController.m
//  ModuleApp
//
//  Created by cwz on 2021/3/23.
//  Copyright © 2021 zkty-teamty-team. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UINavigationControllerDelegate>
/** 保留系统自带的代理 */
@property (strong, nonatomic) id popDelegate;
@end

@implementation MainNavigationController

+ (void)initialize {
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName : [UIFont systemFontOfSize:18 weight:5],  // 字体以及加粗
                                                           NSForegroundColorAttributeName : [UIColor blackColor]  // 字体颜色
                                                           }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    self.navigationController.navigationBar.translucent = NO;  // 不让导航条有穿透效果
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"globalBackArrow"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"globalBackArrow"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 保留滑动返回手势
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            // 因为你把导航控制器自己的返回按钮覆盖了，所以这个代理会取消滑动返回功能，因此再覆盖前将此代理清空。再返回后再将代理还原。
            self.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
    viewController.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    viewController.navigationController.navigationBar.translucent = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]){
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)back {
    [self popViewControllerAnimated:YES];
}
@end

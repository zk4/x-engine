//
//  UINavigationController+Completion.h
//

#import <Foundation/Foundation.h>


@interface UINavigationController (ZK_Completion)
 

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion: (void (^)(void))completion;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion ;

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController*)viewController animated:(BOOL)animated completion: (void (^)(void))completion;

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated completion: (void (^)(void))completion ;

@end

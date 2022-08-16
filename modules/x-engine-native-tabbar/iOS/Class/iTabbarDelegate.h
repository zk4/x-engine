//
//  iTabbar.h
//  Tabbar
//

#ifndef iTabbarDelegate_h
#define iTabbarDelegate_h
@protocol iTabbarDelegate <NSObject>
// 当此方法调用时, 只需要返回当前你认为对的 tabItem 即可.
- (UIViewController*)getCurrentTabItemVC;
- (void)changeTab:(NSInteger)tabIndex;
@end
#endif /* iTabbar_h */

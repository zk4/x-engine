//
//  iTabbar.h
//  Tabbar
//

#ifndef iTabbar_h
#define iTabbar_h
// 该接口是为了兼容自定义的 tabbar.不方便取到 tabbaritem,会导致统一路由失效.
@protocol iTabbarDelegate;
@protocol iTabbar <NSObject>
- (UIViewController*)getCurrentTabItemVC;
- (void)changeTab:(NSInteger)tabIndex;
-(void) registerDelegate:(id<iTabbarDelegate>) delegate;
@end
#endif /* iTabbar_h */

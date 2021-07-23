//
//  iTabbar.h
//  Tabbar
//

#ifndef iTabbar_h
#define iTabbar_h
@protocol iTabbarDelegate;
@protocol iTabbar <NSObject>
- (UIViewController*)getCurrentTabItemVC;
-(void) registerDelegate:(id<iTabbarDelegate>) delegate;
@end
#endif /* iTabbar_h */

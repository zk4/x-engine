


#import "UIViewController+Tag.h"
#import <objc/runtime.h>
#import "iTabBar.h"
#import "XENativeContext.h"
static const  char* KEY_HISTORY_MODEL="KEY_HISTORY_MODEL";


@interface UIViewController (ZK_Tag)

 
@end
@implementation UIViewController (ZK_Tag)
 
- (HistoryModel*) getLastHistory{
    HistoryModel*  _historyModel = objc_getAssociatedObject(self,KEY_HISTORY_MODEL);
    if(!_historyModel){
        UIViewController* vc=  [XENP(iTabbar) getCurrentTabItemVC];
        _historyModel = objc_getAssociatedObject(vc,KEY_HISTORY_MODEL);
        NSAssert(_historyModel, @"找不到 historyModel, 如果你没有使用原生的 tabbar,请继承 iTabBarDelegate 明确拿到 vc, 即使你使用了原生 Tabbar, 也应该实现一下iTabbar,如果这时弹出 alertview,也有可能错 tabbar");
    }
    return _historyModel;
}

- (void)setCurrentHistory:(HistoryModel *) history{
    objc_setAssociatedObject(self,KEY_HISTORY_MODEL,history,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

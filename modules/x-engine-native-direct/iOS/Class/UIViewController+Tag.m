


#import "UIViewController+Tag.h"
#import <objc/runtime.h>
#import "iTabBar.h"
static const  char* KEY_HISTORY_MODEL="KEY_HISTORY_MODEL";


@interface UIViewController (ZK_Tag)

 
@end
@implementation UIViewController (ZK_Tag)
 
- (HistoryModel*) getLastHistory{
    HistoryModel*  _historyModel = objc_getAssociatedObject(self,KEY_HISTORY_MODEL);
    if(!_historyModel){
        id<iTabBar> tabbar = self;
        NSAssert(tabbar, @"找不到 historyModel, 如果你没有使用原生的 tabbar,请继承 iTabBar 并实现接口");
        if(tabbar){
            UIViewController* vc= [tabbar getCurrentTabItemVC];
            _historyModel = objc_getAssociatedObject(vc,KEY_HISTORY_MODEL);
        }
    }
    return _historyModel;
}

- (void)setCurrentHistory:(HistoryModel *) history{
    objc_setAssociatedObject(self,KEY_HISTORY_MODEL,history,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end




#import "UIViewController+Tag.h"
#import <objc/runtime.h>
static const  char* KEY_HISTORY_MODEL="KEY_HISTORY_MODEL";


@interface UIViewController (ZK_Tag)

 
@end
@implementation UIViewController (ZK_Tag)
 
- (HistoryModel*) getLastHistory{
    HistoryModel*  _historyModel = objc_getAssociatedObject(self,KEY_HISTORY_MODEL);
    return _historyModel;
}

- (void)setCurrentHistory:(HistoryModel *) history{
    objc_setAssociatedObject(self,KEY_HISTORY_MODEL,history,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

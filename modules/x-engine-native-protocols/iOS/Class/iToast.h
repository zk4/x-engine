//
//  iToast.h
//  Toast
//

#ifndef iToast_h
#define iToast_h
@protocol iToast <NSObject>
- (void)toastWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)toast:(NSString *)msg;
- (void)toast:(NSString *)msg duration:(NSTimeInterval)duration;
- (void)toastCurrentView:(NSString *)msg duration:(NSTimeInterval)duration;
@end
#endif /* iToast_h */

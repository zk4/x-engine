//
//  iToast.h
//  Toast
//

#ifndef iToast_h
#define iToast_h
@protocol iToast <NSObject>
- (void)toast:(NSString *)msg;
- (void)toast:(NSString *)msg duration:(NSTimeInterval)duration;
@end
#endif /* iToast_h */

//
//  Unity.h
//  XEngine


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Unity : NSObject

+ (Unity *)sharedInstance;
- (UIView *)topView;
- (UIViewController *)getCurrentVC;

@end



//
//  moduleTableViewCell.h
//  app
//
//  Created by 李宫 on 2020/9/25.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol moduleTableViewCellDelegate <NSObject>
- (void)module_nav:(UIButton *_Nullable)button;
- (void)module_nav_push:(UIButton *_Nullable)button;
- (void)module_localstorage:(UIButton *_Nullable)button;
- (void)module_camera:(UIButton *_Nullable)butto;
- (void)module_device:(UIButton *_Nullable)button;
- (void)module_bluetooth:(UIButton *_Nullable)button;
- (void)module_dcloud:(UIButton *_Nullable)button;
- (void)module_lope:(UIButton *_Nullable)button;
- (void)module_network:(UIButton *_Nullable)button;
- (void)module_offline:(UIButton *_Nullable)button;
- (void)module_router:(UIButton *_Nullable)button;
- (void)module_scan:(UIButton *_Nullable)button;
- (void)module_UI:(UIButton *_Nullable)button;

@end
@interface moduleTableViewCell : UITableViewCell
@property (nonatomic, weak) id<moduleTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

//
//  PopoverViewController.h
//  AFNetworking
//
//  Created by edz on 2020/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopoverViewController : UIViewController
@property (nonatomic, strong) NSArray *itemList; /** mune列表 */
@property (nonatomic, copy) void (^selectCellBlock)(UITableView *tableView, NSIndexPath *indexPath); /** 选择cell的回调 */
@end

NS_ASSUME_NONNULL_END

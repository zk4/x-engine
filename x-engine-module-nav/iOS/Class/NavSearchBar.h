//
//  NavSearchBar.h
//  nav
//
//  Created by 吕冬剑 on 2020/9/16.
//  Copyright © 2020 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NavSearchBarDTO;
@interface NavSearchBar : UIView

-(void)setSearchModel:(NavSearchBarDTO *)dto;

@end

NS_ASSUME_NONNULL_END

//
//  ZKTYModel.h
//  model
//
//  Created by 李宫 on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JSONModel.h"

@interface itemListModel : JSONModel

@end

@interface ZKTYModel : JSONModel
@property (nonatomic,copy)NSString* title;
@property (nonatomic,copy)NSString * content;
@property (nonatomic,strong)NSArray <itemListModel*>* itemList;
@end



//
//  NSString+URLQuery.h
//  ModuleApp
//
//  Created by zk on 2021/3/28.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (XENGINE_URLQuery)
    - (NSDictionary*)uq_queryDictionary;
    - (NSString*)uq_URLByRemovingQuery;

    - (NSString*) uq_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary;
    - (NSString*)uq_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary
                            withSortedKeys:(BOOL) sortedKeys;

    - (NSString*)uq_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                withSortedKeys:(BOOL) sortedKeys;

    - (NSString*)uq_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary;

    - (NSString*)SPAUrl2StandardUrl;
    - (NSString*)SPAUrlEncode;

@end


NS_ASSUME_NONNULL_END

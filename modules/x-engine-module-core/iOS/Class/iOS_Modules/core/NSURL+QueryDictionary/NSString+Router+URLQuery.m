//
//  NSString+Router+URLQuery.m
//  ModuleApp
//
//  Created by zk on 2021/3/28.
//  Copyright © 2021 zkty-team. All rights reserved.
//

#import "NSString+Router+URLQuery.h"
#import "NSURL+QueryDictionary.h"

#define URL(STRING) ((NSURL*) [NSURL URLWithString: STRING])


@implementation NSString (XENGINE_URLQuery)
- (NSDictionary*)uq_queryDictionary{
    return URL(self).uq_queryDictionary;
}
- (NSString*)uq_URLByRemovingQuery{
    return [self urlString2SPAUrl:URL(self).uq_URLByRemovingQuery.absoluteString];
}
- (NSString*)uq_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                   withSortedKeys:(BOOL) sortedKeys{
    NSString*   raw= [URL(self) uq_URLByReplacingQueryWithDictionary:queryDictionary withSortedKeys:sortedKeys].absoluteString;
    return [self urlString2SPAUrl:raw];
}

- (NSString*)uq_URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary{
    NSString*   raw= [URL(self) uq_URLByReplacingQueryWithDictionary:queryDictionary withSortedKeys:FALSE].absoluteString;
    return [self urlString2SPAUrl:raw];
}

- (NSString*)urlString2SPAUrl:(NSString*)raw {
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< raw.length;i++){
        char cc= [raw characterAtIndex:i];

        if(cc == '?' && questionMark == -1){
            questionMark=i;
        }
        else if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* sub1= [raw substringToIndex:questionMark];
        NSString* sub2= [raw substringWithRange:NSMakeRange(questionMark, hashtagMark-questionMark)];
        NSString* sub3= [raw substringFromIndex:hashtagMark];
        return [NSString stringWithFormat:@"%@%@%@",sub1,sub3,sub2] ;
    }
    return raw;
}
- (NSString*)uq_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary
                            withSortedKeys:(BOOL) sortedKeys{
    NSString*   raw= [URL(self) uq_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:sortedKeys].absoluteString;
    return [self urlString2SPAUrl:raw];

}
- (NSString*) uq_URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary{
    return [self uq_URLByAppendingQueryDictionary:queryDictionary withSortedKeys:FALSE];
}
@end

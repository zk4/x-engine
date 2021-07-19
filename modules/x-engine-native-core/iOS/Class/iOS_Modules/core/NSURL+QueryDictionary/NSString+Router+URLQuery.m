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



static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
static NSString *const kSlash               = @"/";

//  注意这个方法虽然做了 encod .但并不严谨.
//  比如fragment 就是里带了?参数.理论上,你要先 encode 这个 fragment.再做拆解.
- (NSString*)SPAUrl2StandardUrl{
    int questionMark = -1;
    int hashtagMark = -1;

    for (int i=0;i< self.length;i++){
        char cc= [self characterAtIndex:i];

        if(cc == '#' && hashtagMark == -1){
            hashtagMark=i;
        }
        // 仅当找到 hashtag 后才再找?, 不然不是 SPA url
        if(hashtagMark != -1 && cc == '?' && questionMark == -1){
            questionMark=i;
        }
    }
    if(questionMark != -1 && hashtagMark != -1){
        NSString* host= [self substringToIndex:hashtagMark];
        NSString* fragment= [self substringWithRange:NSMakeRange(hashtagMark, questionMark-hashtagMark)];
        // encode # 后面的参数, 不要连带着#也 encode 了.
        if(fragment){
            fragment =[NSString stringWithFormat:@"#%@",[[fragment substringFromIndex:1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        }
        NSString* query=[ [self substringFromIndex:questionMark]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSString stringWithFormat:@"%@%@%@",host,query,fragment] ;
    }
    return self;
}

- (NSString*)SPAUrlEncode{
 
   NSString* standardUrl =  [self SPAUrl2StandardUrl];
    NSURL * url = [NSURL URLWithString:standardUrl];
    //[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]
    return [NSString stringWithFormat:@"%@://%@?%@#%@",
            url.scheme,
            [url.path stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLPathAllowedCharacterSet]],
            [url.query stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]],
            [url.fragment stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLFragmentAllowedCharacterSet]]
            ];
}
@end

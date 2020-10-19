//
//  Stack.h
//  IOSHybridAppDemo
 
#import <Foundation/Foundation.h>
@interface Stack : NSObject {
    NSMutableArray *contents;
}

- (void)push:(id)object;
- (id)pop;
- (id)top;
- (void)debugInfo;
@end
 
 

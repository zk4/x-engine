//
//  Stack.m
//  IOSHybridAppDemo
 
 
#import "Stack.h"


@implementation Stack

// superclass overrides

- (id)init {
    if (self = [super init]) {
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}

// Stack methods

- (void)push:(id)object {
    [contents addObject:object];
}

- (id)pop {
  id lastObject = [contents lastObject];
  [contents removeLastObject];
  return lastObject;
}

- (void)debugInfo{
    for (NSString *curElement in contents)
    {
       NSLog(@"current stack: %@", curElement);
    }
}

- (id)top{
    return  [contents lastObject];
}

@end

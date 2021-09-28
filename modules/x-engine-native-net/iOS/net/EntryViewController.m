//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import "iToast.h"
#import "iNet.h"

@interface ConfigFilter:NSObject <iFilter>
@end

@implementation ConfigFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;
    [chain doFilter:session request:request response:response];
}
@end

@interface MergeRequestFilter:NSObject <iFilter>
@property (atomic, strong)   NSMutableDictionary<NSString*,NSMutableArray*>* requests;
@end

@implementation MergeRequestFilter

- (instancetype)init {
    if (self = [super init]) {
        self.requests=[NSMutableDictionary new];
    }
    return self;
}

- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    NSString* key = request.URL.absoluteString;
    id queue =  [self.requests objectForKey:key];
    if([self.requests objectForKey:key]){
        [XENP(iToast) toast:@"merged request"];
        [queue addObject:response];
        return;
    }else{
        NSMutableArray* queue = [NSMutableArray new];
        [queue addObject:response];
        [self.requests setObject:queue forKey:key];
        [chain doFilter:session request:request response:^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
            NSMutableArray* queue =  [self.requests objectForKey:key];
            for (ZKResponse r in queue) {
                r(data,res,error);
            }
            [self.requests removeObjectForKey:key];
            
        }];
    }
}

@end



@interface LoggingFilter:NSObject <iFilter>
@end

@implementation LoggingFilter
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    session.configuration.HTTPMaximumConnectionsPerHost = 0;
    
    NSLog(@"%@", @"request start");
    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
        
        NSString *str  = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        NSString* newStr= [NSString stringWithFormat:@"%@%@",str,@"back 1"];
        
        NSData* newData =  [newStr dataUsingEncoding:NSUTF8StringEncoding];
        response(newData,res,error);
    };
    
    [chain doFilter:session request:request response:newResponse];
}
@end

@interface LoggingFilter2:NSObject <iFilter>
@end

@implementation LoggingFilter2
- (void)doFilter:(nonnull NSURLSession *)session request:(nonnull NSMutableURLRequest *)request response:(nonnull ZKResponse)response chain:(id<iFilterChain>) chain {
    
    NSLog(@"%@", @"request start 2");
    ZKResponse newResponse = ^(NSData * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error){
        NSData* newData =  [@"back 2" dataUsingEncoding:NSUTF8StringEncoding];
        response(newData,res,error);
        
    };
    
    [chain doFilter:session request:request response:newResponse];
}
@end


@interface EntryViewController ()
@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{

    id config = [ConfigFilter new];
    id merged = [MergeRequestFilter new];
 
    
    for (int i =0; i<10; i++) {
        id ok = [[XENP(iNetManager) one] build:({
            NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
            req;
        })];
        [ok addFilter:config];
        [ok addFilter:merged];
        [ok send:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                [XENP(iToast) toast:[error localizedDescription]];
            }else{
                NSLog(@"%@", @"success");
                [XENP(iToast) toast:@"success"];
                NSLog(@"back -> %@",[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding]);
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];
}

@end

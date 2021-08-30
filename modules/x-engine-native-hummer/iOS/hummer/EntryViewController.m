//
//  EntryViewController.m
//  ModuleApp
//

#import "EntryViewController.h"
#import "XENativeContext.h"
#import <Hummer/Hummer.h>

@interface EntryViewController ()

@end

@implementation EntryViewController
- (IBAction)Action:(id)sender {
    [self pushTestModule];
}

-(void) pushTestModule{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *xmlPath = [path stringByAppendingPathComponent:@"index.js"];
    NSString *xmlString = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:nil];

    [Hummer evaluateScript:xmlString fileName:@"index.js" inRootView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushTestModule];

}

@end

//
//  EngineContext.m

#import "XEngineContext.h"
#import <MBProgressHUD/MBProgressHUD.h>
//#import <x-engine-module-engine/XEOneWebViewPool.h>
#import "xengine__module_BaseModule.h"
#import <objc/message.h>
@interface XEngineContext ()
@property (nonatomic, strong) NSMutableArray<NSString*>* moduleClassNames;
@property (nonatomic, strong) NSMutableArray<xengine__module_BaseModule*>* modules;
@property (nonatomic, strong) NSMutableArray* applicationDelegateModules;
@property (nonatomic, strong) NSMutableDictionary<NSString*,xengine__module_BaseModule*>* moduleName2Moudle;
@property (nonatomic, strong) NSMutableDictionary<NSString*,NSMutableArray*>* moduleName2MoudleProtocolnames;

@end

@implementation XEngineContext

+ (instancetype)sharedInstance{
    static XEngineContext *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XEngineContext alloc] init];
    });
    return sharedInstance;
}

- (void) start{
    // lazy init
    self.moduleClassNames  = nil;
    
    self.modules = [NSMutableArray array];
    self.applicationDelegateModules= [NSMutableArray array];
    self.moduleName2Moudle= [[NSMutableDictionary alloc] init];
    self.moduleName2MoudleProtocolnames= [[NSMutableDictionary alloc] init];
    [self initModules];
    [self onAllModulesInited];
    
//    [XEOneWebViewPool sharedInstance];
}

- (instancetype)init {
    if (self = [super init])
    {
    }
    return self;
}

- (NSMutableArray*) modules{
    return _modules;
}

- (void) onAllModulesInited{
    for (xengine__module_BaseModule *module in self.modules) {
        [module onAllModulesInited];
    }
}

-(NSMutableArray*) getProtocols:(Class) cls{
    unsigned count;
    __unsafe_unretained Protocol **pl = class_copyProtocolList(cls, &count);
    
    NSMutableArray * ret  = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned i = 0; i < count; i++) {
        NSString * name = [NSString stringWithUTF8String:protocol_getName(pl[i])];
        [ret addObject: name];
    }
    free(pl);
    return ret;
}

- (void) initModules{
    
    [self getModuleClassName];
    for (NSString *moduleName in self.moduleClassNames)
    {
        Class cls = NSClassFromString(moduleName);
        
        id rawmoduleClass = [[cls alloc] init];
        xengine__module_BaseModule * moduleClass = (xengine__module_BaseModule*) rawmoduleClass;
        
        [self.moduleName2Moudle setObject:moduleClass forKey:moduleName];
        
        NSMutableArray*  protocols = [self getProtocols:cls];
        [self.moduleName2MoudleProtocolnames setObject:protocols forKey:moduleName];
        
        BOOL  ifUIApplicationDelegate =[moduleClass conformsToProtocol:@protocol(UIApplicationDelegate)];
        
        if (ifUIApplicationDelegate){
            [self.applicationDelegateModules addObject:moduleClass];
        }      
        
        [self.modules addObject:moduleClass];
        NSLog(@"moudle found: %@",moduleClass.moduleId);
    }
    
    self.modules = [[self.modules sortedArrayUsingComparator:^(xengine__module_BaseModule* left, xengine__module_BaseModule* right) {
        
        if ([left order] >[right order]){
            return NSOrderedDescending;
        }else  if ([left order] <[right order]){
            return NSOrderedAscending;
        }
        return   NSOrderedSame;
    }] mutableCopy];
}

- (id) getModuleByName: (NSString*) key {
    return [self.moduleName2Moudle objectForKey:key];
}

- (id) getModuleByProtocol:(Protocol *) proto{
    // if found multipal modules, choose only the first found, or you can call getModulesByProtocol:
    NSString* protocoalName = NSStringFromProtocol(proto);
    for (NSString *key in self.moduleName2MoudleProtocolnames) {
        NSMutableArray* protocolNames= [self.moduleName2MoudleProtocolnames objectForKey:key];
        if ( [protocolNames containsObject: protocoalName] ) {
            return [self.moduleName2Moudle objectForKey:key];
        }
    }
    return nil;
}

- (NSMutableArray*) getModulesByProtocol:(Protocol *) proto{
    NSMutableArray* modules =nil;
    NSString* protocoalName = NSStringFromProtocol(proto);
    for (NSString *key in self.moduleName2MoudleProtocolnames) {
        NSMutableArray* protocolNames= [self.moduleName2MoudleProtocolnames objectForKey:key];
        if ( [protocolNames containsObject: protocoalName] ) {
            if (!modules){
                // lazy init
                modules =[NSMutableArray array];
            }
            [modules addObject:[self.moduleName2Moudle objectForKey:key]];
        }
    }
    return modules;
}
- (void) onApplicationDelegate:(NSString*) eventName arg1:(id)application args:(id) args{
    SEL  sel = NSSelectorFromString(eventName);
    for (id d in self.applicationDelegateModules){
        if( [d respondsToSelector:sel] ) {
            // invoke the method
            id(*action)(id,SEL,id,id) = (id(*)(id,SEL,id,id))objc_msgSend;
            action(d, sel,application, args);
        }
    }
}

bool startsWith(const char *pre, const char *str)
{
    size_t lenpre = strlen(pre),
    lenstr = strlen(str);
    return lenstr < lenpre ? false : memcmp(pre, str, lenpre) == 0;
}

- (NSMutableArray *) getModuleClassName
{
    if(self.moduleClassNames) return self.moduleClassNames;
    
    int numClasses;
    Class * classes = NULL;
    
    NSMutableArray *classNameArray = [NSMutableArray array];
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        
        numClasses = objc_getClassList(classes, numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            Class class = classes[i];
            const char *className = class_getName(class);
            
            if (startsWith( "__xengine__module_",className) )
            {
                NSString *claseeNameString = [[NSString alloc] initWithCString:className encoding:NSUTF8StringEncoding];
                [classNameArray addObject:claseeNameString];
            }
        }
        free(classes);
    }
    
    
    self.moduleClassNames = classNameArray;
    return classNameArray;
}

@end

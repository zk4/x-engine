//
//  EngineContext.m

#import "XEngineContext.h"
#import "xengine__module_BaseModule.h"
#import <objc/message.h>
@interface XEngineContext ()
@property (nonatomic, strong) NSMutableArray<NSString*>* moduleClassNames;
@property (nonatomic, strong) NSMutableArray<xengine__module_BaseModule*>* modules;
@property (nonatomic, strong) NSMutableArray* applicationDelegateModules;
@property (nonatomic, strong) NSMutableDictionary<NSString*,xengine__module_BaseModule*>* moduleName2Moudle;
@property (nonatomic, strong) NSMutableDictionary<NSString*,xengine__module_BaseModule*>* moduleId2Moudle;

@property (nonatomic, strong) NSMutableDictionary<NSString*,NSMutableArray*>* moduleName2MoudleProtocolnames;

@end

@implementation XEngineContext

X_MODULE(com.zkty.module.core,XEngineContext)

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
    self.moduleId2Moudle = [[NSMutableDictionary alloc]init];
    self.moduleName2MoudleProtocolnames= [[NSMutableDictionary alloc] init];
    [self initModules];
    [self onAllModulesInited];
}
 

- (NSMutableArray*) modules{
    return _modules;
}

- (void) onAllModulesInited{
    for (xengine__module_BaseModule *module in self.modules) {
        [module onAllModulesInited];
    }
}
- (id) getModuleByName:(NSString*) clazzName{
    return [self.moduleName2Moudle objectForKey:clazzName];
}

-(id)getModuleById:(NSString *)moduleId{
    return [self.moduleId2Moudle objectForKey:moduleId];
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
    for (NSString *moduleName in self.moduleClassNames)
    {
        Class cls = NSClassFromString(moduleName);
        
        id rawmoduleClass = [[cls alloc] init];
        xengine__module_BaseModule * moduleClass = (xengine__module_BaseModule*) rawmoduleClass;
        
        [self.moduleName2Moudle setObject:moduleClass forKey:moduleName];
        [self.moduleId2Moudle setObject:moduleClass forKey:moduleClass.moduleId];

        
        NSMutableArray*  protocols = [self getProtocols:cls];
        [self.moduleName2MoudleProtocolnames setObject:protocols forKey:moduleName];
        

        
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

- (void) onApplicationDelegate0:(NSString*) eventName arg1:(id)application {
    
    SEL  sel = NSSelectorFromString(eventName);
    for (id d in self.applicationDelegateModules){
        if( [d respondsToSelector:sel] ) {
            // invoke the method
            id(*action)(id,SEL,id) = (id(*)(id,SEL,id))objc_msgSend;
            action(d, sel,application);
        }
    }
}

bool startsWith(const char *pre, const char *str)
{
    size_t lenpre = strlen(pre),
    lenstr = strlen(str);
    return lenstr < lenpre ? false : memcmp(pre, str, lenpre) == 0;
}



- (void) registerModuleId:(NSString*) moduleId clazz:(Class) clazz{
    NSLog(@"moduleId:%@, clazz:%@, %@",moduleId,clazz);
}

@end

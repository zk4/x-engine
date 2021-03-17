//
//  EngineContext.m

#import "XEngineContext.h"
#import "xengine__module_BaseModule.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface XEngineContext ()
@property (nonatomic, strong) NSMutableArray<NSString *> *moduleClassNames;
@property (nonatomic, strong) NSMutableArray<Class> *moduleClasses;

@property (nonatomic, strong) NSMutableArray<xengine__module_BaseModule *> *modules;
@property (nonatomic, strong) NSMutableArray *applicationDelegateModules;
@property (nonatomic, strong) NSMutableDictionary<NSString *, xengine__module_BaseModule *> *moduleId2Moudle;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *moduleId2MoudleProtocolnames;

@end

// DONE 生命周期通知，应用到后台，通知组件等
// 有生命周期需求，自行在 load 里注册通知，见 + (void) load

// TODO 集成路由 router， 有 UI 才有 router 的意义， 路由的目的地可能是 webview 也可能是原生。
@implementation XEngineContext

// 在各自对应的模块中重写 + load方法,监听UIApplicationDidFinishLaunchingNotification通知
+ (void)load {
__block id observer =
    [[NSNotificationCenter defaultCenter]
        addObserverForName:UIApplicationDidFinishLaunchingNotification
                    object:nil
                     queue:nil
                usingBlock:^(NSNotification *note) {
                  [[XEngineContext sharedInstance] start];
                  [[NSNotificationCenter defaultCenter] removeObserver:observer];
                }];
}
+ (instancetype)sharedInstance {
static XEngineContext *sharedInstance = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
  sharedInstance = [[XEngineContext alloc] init];
});
return sharedInstance;
}

- (void)start {
self.moduleClassNames = [NSMutableArray array];
self.modules = [NSMutableArray array];
self.applicationDelegateModules = [NSMutableArray array];

self.moduleId2Moudle = [[NSMutableDictionary alloc] init];
self.moduleId2MoudleProtocolnames = [[NSMutableDictionary alloc] init];
[self initModules];
[self onAllModulesInited];
}

- (NSMutableArray *)modules {
return _modules;
}

- (void)onAllModulesInited {
for (xengine__module_BaseModule *module in self.modules) {
    [module onAllModulesInited];
}
}

- (id)getModuleById:(NSString *)moduleId {
return [self.moduleId2Moudle objectForKey:moduleId];
}

- (NSMutableArray *)getProtocols:(Class)cls {
unsigned count;
__unsafe_unretained Protocol **pl = class_copyProtocolList(cls, &count);

NSMutableArray *ret = [NSMutableArray arrayWithCapacity:count];

for (unsigned i = 0; i < count; i++) {
    NSString *name = [NSString stringWithUTF8String:protocol_getName(pl[i])];
    [ret addObject:name];
}
free(pl);
return ret;
}

- (void)initModules {
for (Class cls in self.moduleClasses) {
    id rawmoduleClass = [[cls alloc] init];
    xengine__module_BaseModule *moduleClass = (xengine__module_BaseModule *)rawmoduleClass;
    NSString *moduleId = [moduleClass moduleId];

    [self.moduleId2Moudle setObject:moduleClass forKey:moduleClass.moduleId];

    NSMutableArray *protocols = [self getProtocols:cls];
    [self.moduleId2MoudleProtocolnames setObject:protocols forKey:moduleId];

    [self.modules addObject:moduleClass];
    NSLog(@"moudle found: %@", moduleClass.moduleId);
}

self.modules = [[self.modules sortedArrayUsingComparator:^(xengine__module_BaseModule *left, xengine__module_BaseModule *right) {
  if ([left order] > [right order]) {
      return NSOrderedDescending;
  } else if ([left order] < [right order]) {
      return NSOrderedAscending;
  }
  return NSOrderedSame;
}] mutableCopy];
}

- (id)getModuleByProtocol:(Protocol *)proto {
// if found multipal modules, choose only the first found, or you can call getModulesByProtocol:
NSString *protocoalName = NSStringFromProtocol(proto);
for (NSString *moduleId in self.moduleId2MoudleProtocolnames) {
    NSMutableArray *protocolNames = [self.moduleId2MoudleProtocolnames objectForKey:moduleId];
    if ([protocolNames containsObject:protocoalName]) {
        return [self.moduleId2Moudle objectForKey:moduleId];
    }
}
return nil;
}

- (NSMutableArray *)getModulesByProtocol:(Protocol *)proto {
NSMutableArray *modules = nil;
NSString *protocoalName = NSStringFromProtocol(proto);
for (NSString *moduleId in self.moduleId2MoudleProtocolnames) {
    NSMutableArray *protocolNames = [self.moduleId2MoudleProtocolnames objectForKey:moduleId];
    if ([protocolNames containsObject:protocoalName]) {
        if (!modules) {
            // lazy init
            modules = [NSMutableArray array];
        }
        [modules addObject:[self.moduleId2Moudle objectForKey:moduleId]];
    }
}
return modules;
}

bool startsWith(const char *pre, const char *str) {
size_t lenpre = strlen(pre),
       lenstr = strlen(str);
return lenstr < lenpre ? false : memcmp(pre, str, lenpre) == 0;
}

- (void)registerModuleByClass:(Class)clazz {
[self.moduleClasses addObject:clazz];
}

@end

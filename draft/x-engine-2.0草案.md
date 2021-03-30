## 目标

### 引擎

- 基础架构重构 (谢飞，陈武峥)
- 规范 URL 解析  (刘正青，谢飞，陈武峥)
- 使用 protocol 来实现 direct 模块，统一 router 与 nav (刘正青，谢飞，陈武峥)

### 工具

- x-cli 封装同步代码的生成 （刘正青）
- js 调用原生层，原生调用模块层。 原生由 x-cli 生成。（刘正青）

### 前端

- 最佳本地 h5 规范
  - 带 microapp.json 功能
  - 更底层的 jsi api 调用，不再需要安装 npm 包

### 规范

- iOS 基于 xcode 的自动 indent
- android 方案 (谢飞)



## 目标引导

### 基础架构重构

将 Native 模块管理与 JSI 模块管理做为父子。

- 保证单向依赖

- 可测试

  ![image-20210329182802473](https://raw.githubusercontent.com/zk4/image_backup/main/img/image-20210329182802473.png)

上图解释：



NativeContext 只管理实现了 NativeModule 的原生模块。

JSIContext 只管理实现了 JSIModule 的 JSI  模块。



#### 文件夹组织形式

```
├── core
│   ├── NativeContext.h
│   ├── NativeContext.m
│   ├── NativeModule.h
│   ├── NativeModule.m
├── jsi
│   ├── direct
│   │   ├── JSIDirectModule.h
│   │   ├── JSIDirectModule.m
│   │   └── gen
│   │       ├── xengine__jsi_direct.h
│   │       └── xengine__jsi_direct.m
│   └── legacy
│       ├── nav
│       │   ├── JSIOldNavModule.h
│       │   ├── JSIOldNavModule.m
│       │   └── gen
│       │       ├── xengine__module_nav.h
│       │       └── xengine__module_nav.m
│       └── router
│           ├── JSIOldRouterModule.h
│           └── JSIOldRouterModule.m
│           └── gen
│               ├── xengine__module_router.h
│               └── xengine__module_router.m
├── native
│   ├── direct
│   │   ├── direct.manager
│   │   │   ├── DirectManagerModule.h
│   │   │   └── DirectManagerModule.m
│   │   ├── h5
│   │   │   ├── H5DirectModule.h
│   │   │   └── H5DirectModule.m
│   │   ├── microapp
│   │   │   ├── MicroappDirectModule.h
│   │   │   ├── MicroappDirectModule.m
│   │   └── omp
│   │       ├── OmpDirectModule.h
│   │       └── OmpDirectModule.m
│   ├── jsi
│   │   ├── JSIContext.h
│   │   ├── JSIContext.m
│   │   ├── JSIModule.h
│   │   └── JSIModule.m
│   ├── open
│   │   ├── h5
│   │   │   ├── OpenH5Module.h
│   │   │   └── OpenH5Module.m
│   │   ├── omp
│   │   │   ├── OpenOmpModule.h
│   │   │   └── OpenOmpModule.m
│   │   ├── open.manager
│   │   │   ├── OpenManagerModule.h
│   │   │   └── OpenManagerModule.m
│   └── ui
│       └── nav
│           ├── NavUtil.h
│           └── NavUtil.m
└── protocols
    ├── iDirect.h
    ├── iDirectManager.h
    └── iStorage.h

```



### direct 模块

增加 direct 的 native 与 jsi 模块，统一原来的 Router 与 Nav。 逻辑上一样。 

- Router 与 Nav 的本质区别是 host 从哪来。 而 host 的我们可以自己缓存在某地。
- Router 与 nav 将在以后不再使用，只为兼容。

以下为 direct 通用数据结构

- 规范字段,(oc 举例)

  ``` objective-c
  @interface DirectPushDTO: JSONModel
    	@property(nonatomic,copy)   NSString* scheme;
     	@property(nonatomic,copy)   NSString* host;
     	@property(nonatomic,copy)   NSString* pathname;
     	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* query;  
      @property(nonatomic,strong) NSDictionary<NSString*,NSString*>* params; // 为 vue-router 兼容，
      @property(nonatomic,assign) BOOL hideNavbar;
  @end
      
  
  @interface DirectBackDTO: JSONModel
      @property(nonatomic,copy)   NSString* scheme;
      @property(nonatomic,copy)   NSString* host;
      @property(nonatomic,copy)   NSString* pathname;
  @end
  ```

  

### 规范 URL 解析

按照 URL 规范，以上命名根据 RFC 定义

注意：

- path 与 pathname 的区别。pathname 一定要带 / 开头
- query 不带问号
- host 包含端口，如果port 是 80，host 可省略端口

![image-20210330114053584](https://raw.githubusercontent.com/zk4/image_backup/main/img/image-20210330114053584.png)





### microapp.json

功能集成

 

### 最佳本地 h5 规范

- 带 microapp.json 功能
- 更底层的 jsi api 调用，不再需要安装 npm 包



一直都可以直接通过 namespace.methodname， args  的形式调用，只需要安装 engine 包即可。

```
  engine.bridge.call('com.zkty.jsi.direct.push',{
    scheme: 'omp',
    pathname:'0'
  },function(res){
  })
```

 

## 开发方式



1. 生成 jsi 模块项目：

    - 找到模板 x-engine-jsi-template,  执行

        ```
        coge -r
        //检验
        coge
        // 出现 coge  x-engine-jsi-template @:app
        ```

        

        ```
        coge x-engine-jsi-template module-xxxx:jsi-ui xxxx:ui @:x-engine-jsi-ui -w
        ```

        

2. 编写 model.ts 

3. 生成代码

   使用 x-cli version >= 1.7.0

   ```
   sudo npm install @zkty-team@x-cli -g
   ```

   在生成的模块项目下执行

   ```
   x-cli model model.ts  -t 2
   ```

   

## 注意事项

### 0 警告

保证业务工程 0 警告，除非明确知道警告无所谓。抵制警告。



### model.ts

如果 model.ts 里没有定义 dto，只是使用了字典，字典里value 严禁使用 bool 值或者数字。 只允许字符串。



### vue-route  里 query 与 hash

在 rfc 里， hash 是在 query 后面，作用是不刷新页面跳转到相应 hash位置。# 后面的值永远也不会传给服务器。

如 http://example.com?search=a#hash



但如是使用的 vue 框架，在 js 里调用 vue-router 时， vue-router 会改掉 url 里的地址， 拼成形如这样的地址以实现跳转

```
http://example.com/#/some/path?search=a#hash
```

以 # 为分隔，后面的为路由地址 /some/path,  而 search=a#hash 为vue-router的参数

首先要说明， 这里的 hash 还是遵循了 rfc 的规范，不会将 # 后面的值传给服务器。

*但是，后面的 ?search=a#hash 就不是 'query' 了。只是长的像 query 的 vue-router $route.query 而已。*

而真正的 url query 并不会与 vue-router 共享。

```
http://example.com?name=zk/#/some/path?search=a#hash
```

query 为  name=zk

$route.query 为 search=a#hash



### url 变了

有几种情况会改变 url

1. 浏览器在发送请求前就会自动增加。

   http://www.baidu.com  → http://www.baidu.com/

2. 服务端返回了 304 重定向

   https://www.baidu.com/wrongpage.html  → location: https://www.baidu.com/correctpage.html





**参考**

https://www.ruanyifeng.com/blog/2011/03/url_hash.html







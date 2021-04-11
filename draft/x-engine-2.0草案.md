## 目标

### 引擎

- [x] 基础架构重构 (谢飞，陈武峥)

- [x] 规范 URL 解析  (刘正青，谢飞，陈武峥)

- [x] 使用 protocol 来实现 direct 模块，统一 router 与 nav (刘正青，谢飞，陈武峥)

- [ ] h5 页面生命周期告知，页面进入与离开

- [ ] vue-router 有没有更快的路由方法？不使用 loadurl

- [ ] broadcast 增加数据结构

- [ ] mergeDict 写测试

- [ ] 代理 webview 缓存，现在每次都做了 304 请求。

- [ ] 打开不存在页面会卡死。

- [ ] 参考 dcloud api

- [ ] 带 microapp.json 功能

  - [ ] 安全
  - [ ] 网络
  
  
  
  
  
  

### 工具

- [x] x-cli 封装同步代码的生成 （刘正青）

### h5 端

- [ ] 最佳本地 h5 规范 4.7 号 完成
  - [x] 打包成一个文件
  - [ ] 带 microapp.json
  - [x] 更底层的 jsi api 调用，不再需要安装 npm 包
  - [ ] 秒开第一页（骨架屏）
  - [ ] navbar 示例
  - [ ] 打开另一个微应用示例
- [ ] 最佳 vite 模板

### 风格

- [ ] git 流程提交按 gitlab flow 流程运行.如果是在 github 里,按 github flow 运行.

- [ ] iOS 基于 xcode 的自动 indent
- [ ] android 方案 (谢飞)



## 目标引导

### 基础架构重构

将 Native 模块管理与 JSI 模块管理做为父子。

- 保证单向依赖

- 可测试

  ![image-20210402141338188](https://raw.githubusercontent.com/zk4/image_backup/main/img/image-20210402141338188.png)

上图解释：



NativeContext 只管理实现了 NativeModule 的原生模块。

JSIContext 只管理实现了 JSIModule 的 JSI  模块。



### 父子模块

比如 direct 是子模块， directManager 是父模块。父模块管理子模块。 

#### direct 模块

增加 direct 的 native 与 jsi 模块，统一原来的 Router 与 Nav。 逻辑上一样。 

- Router 与 Nav 的本质区别是 host 从哪来。 而 host 的我们可以自己缓存在某地。
- Router 与 nav 将在以后不再使用，只为兼容。

以下为 directManager 通用数据结构

- 规范字段,(oc 举例)

  ``` objective-c
  // scheme 形如
  // 1. omp     使用(protocol)  http:  协议，webview 带原生 api 功能
  // 2. omps    使用(protocol) https:  协议，webview 带原生 api 功能
  // 3. http    普通(protocol)  http:  协议，webview 不带原生 api 功能
  // 4. https   普通(protocol) https:  协议，webview 不带原生 api 功能
  // 5. microapp 普通(protocol) file:  协议，打开本地微应用文件
  @interface DirectPushDTO: JSONModel
    	@property(nonatomic,copy)   NSString* scheme;
     	@property(nonatomic,copy)   NSString* host;
     	@property(nonatomic,copy)   NSString* pathname;
     	@property(nonatomic,strong) NSDictionary<NSString*,NSString*>* query;  
      @property(nonatomic,strong) NSDictionary<NSString*,NSString*>* params; // 为 vue-router 兼容
  @end
      
  
  @interface DirectBackDTO: JSONModel
    @property(nonatomic,copy)   NSString* scheme;
      @property(nonatomic,copy)   NSString* host;  //以备日后使用
      @property(nonatomic,copy)   NSString* pathname;
  @end
  ```
  



详见 x-engine-protocols 

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
	//async
	engine.api('com.zkty.jsi.direct','push',{
    scheme: 'omp',
    pathname:'0'
  },function(res){
  })
  
  //sync
  let ret = engine.api('com.zkty.jsi.direct','push',{
    scheme: 'omp',
    pathname:'0'
  })
```

 

## 开发方式

### 引擎开发

1. 生成 native 模块项目：

    - 链接模板源 x-engine-native-template,  执行

        ```
        // 安装 coge
        python3 -m pip install coge
        
        // 在 x-engine-native-template 目录执行
        coge -r

        //执行以下命令， 出现 coge x-engine-native-template @:app，则成功链接模板源
        coge
        
        // 生成项目
        coge x-engine-native-template module-xxxx:jsi-ui xxxx:ui @:x-engine-native-ui -w
        ```
        
    
2. （可选）编写接口


3. （可选）生成 jsi 模块项目：

    - 1. 链接模板源 x-engine-jsi-template,  执行

        ```
      // 在 x-engine-jsi-template 目录执行
      coge -r
      
      //执行以下命令， 出现 coge  x-engine-jsi-template @:app，则成功链接模板源
      coge

      // 生成项目
coge x-engine-jsi-template module-xxxx:jsi-ui xxxx:ui @:x-engine-jsi-ui -w
        ```
      
        
      
    - 2. 编写 model.ts 

    - 3. 生成代码

       使用 x-cli version >= 1.7.0

        ```
        sudo npm install @zkty-team@x-cli -g
        ```

    	在生成的模块项目下执行

        ```
        x-cli model model.ts  -t 2
        ```

### 业务开发

####  原生

- 链接模板源 x-engine-app,  执行

  ```
  // 安装 coge
  python3 -m pip install coge
  
  // 在 x-engine-app 目录执行
  coge -r
  
  //执行以下命令， 出现 coge x-engine-app @:app，则成功链接模板源
  coge
  
  // 生成项目
  coge x-engine-app app:<你的项目名> @:<你的项目名> -w
  ```


> 注意生成项目后引用的模块的路径。 保持 x-engine 与 gome_business 在同一级. 忽略 gome_business 里的 x-engine， 将弃用
>
> - x-engine
> - gome_business
>   - x-engine (弃用)
> - times_business

#### microapp / omp 

@陈武峥

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

### nav & router 怎么办？

使用 nav 与 router 的 JSI 调用 direct 模块做兼容处理。



**参考**

https://www.ruanyifeng.com/blog/2011/03/url_hash.html







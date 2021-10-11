## WHY

### 为什么不直接用 Afnetworking ？

1. 设计不灵活。加个 logging 功能还需要修改源码库。

2. 封装并不比系统自带的好用。

3. 让对网络不了解的 iOS 程序员更加加深了对网络的不了解。而在大部分情况下，af 只是用来请求 REST 接口。

   

### YTKNetworking 呢？

总体设计我觉得思路至少是对的。但有几点我不认同。

**接口 异步调用的编排不应该由网络库来做。而应该由比如 GooglePromise 这种来编排。**

缓存，cdn 这种东西不应该在网络请求类里。应该由插件做。



YTKNetworking 说是为大工程而生，在我看起来就是手动要码的太多。

我不知道 YTKNetworking 内部的网络请求类是不是自动生成。

但如果每个接口已经单独拎出来一个类来隔离。那为什么不直接生成这个类？

如果可以生成类，那 android 也可以生成类似的类，多开心。

生成模板可以使用 swagger OPEN API。这样，能与服务端保持高度一致。





## KOHttp



<img src="https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211011150621026.png" alt="image-20211011150621026" style="zoom: 50%;" />

### 需求与设计

1. 希望能够随意定义一个请求的流程。从构造到最终返回。 那我们可以参考经典的 tomcat 的 filter chain 的设计。
2. 希望网络的异步 api 的编排能够比较灵活好用。那直接就选 google promise 了。
3. 希望可以任意切换流程，我们定义请求流程处理类的 filter 集合为管线，Pipeline。只要切换管线我们，就可以任意切换一个请求的流程。
4. 能够基于模板生成平台 api。至少现阶段 iOS 要能用。 未来可以生成 android，js。 模板语言选一种强类型语言即可，处理 AST 比较方便的。比如 typescript。 
5. 希望能够自动生成模板。 那就可以利用上 swagger OPEN API 这类标准。
6. 希望能在任意层面使用 KOHttp，可以基于生成的代码，可以基于直接 KOHttp，甚至，直接使用系统自带的 NSURLMutableRequest.  方便做原始工程的网络库迁移。
7. 希望功能不够时。 牛 b 的你能自己扩展。而不用动 KOHttp 的代码。



### 其他的想法

1. 需不需要对网络做一层抽象。以支持开发者替换任意的网络请求库。感觉上是没啥必要。因为不管是 Afnetworking 还是 YTKNetworking  都是基于系统库。



## 核心逻辑

<img src="https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211008185732224.png" alt="image-20211008185732224" style="zoom:50%;" />

## Pipeline

一组 filter 可以组成 pipeline 可以方便切换

<img src="https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211008152206298.png" alt="image-20211008152206298" style="zoom:50%;" />

## 代码自动生成

编写 api 模板文件. xxxx.ts 名字无所谓。

语法为 typescript， 多了一种类型 int。

```typescript
// 你要生成的类的名字
const apiName = "gm_general_appVersion_checkUpdate";

// 指定生成的 url 的 prefix，通常不指定，需要在代码里指定。比如，切不同的环境
const apiUrlPrefix = ""

// api 的 path
const apiPath = "/gm/general/appVersion/checkUpdate"

// api 的 method
const apiMethod = "POST"

// 请求的参数模型，一定要以 Req 结尾
interface x_api_gm_general_appVersion_checkUpdate_Req {
    // 操作系统（Android、IOS）
    os?: string;
    // 平台（App、POS等）
    platform?: string;
    // 版本号
    versionCode?: int;
    // 版本名称
    versionName?: string;
}

// 返回的参数模型，一定要以 Res 结尾
interface x_api_gm_general_appVersion_checkUpdate_Res {
  // 更新摘要
  digest?: string;
  // 外部地址
  externalUrl?: string;
  //  是否有更新
  isUpdate?: boolean;
  // 备注
  remark?: string;
  // 更新包资源URL
  resUrl?: string;
  //  更新标题
  title?: string;
  // 更新类型（1、软更新；2、强制更新；3、热更新）
  type?: int;
}

```



安装生成工具

```
npm install @zkty-team/x-cli
```

生成文件

```
x-cli dto xxxx.ts
```

将生成 .h 与 .m， 将文件拖入你的工程。



增加一个数据转换的 filter 



使用方式：

方式 1： 基于 google 的 promise 形式

``` objc
x_api_gm_general_appVersion_checkUpdate_Req* req= [x_api_gm_general_appVersion_checkUpdate_Req new];

req.os=@"ios";
req.platform=@"ios";
req.versionCode=0;
req.versionName=@"";

[[[x_api_gm_general_appVersion_checkUpdate new] promise:req] then:^id _Nullable(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable value) {
  NSLog(@"%@",value);
  return nil;
}];

```

 方式 2： 回调形式

```objc
[api setDtoReq:req];
[api request:^(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable data, NSURLResponse * _Nullable res, NSError * _Nullable error) {
	NSLog(@"%@",data);
}];
```





## 基于 swagger 生成 xxxx.ts

由于 swagger 的数据结构与 api 模板不能完全对应。比如少了 pipeline 的概念。但可以在生成后手动再修改。



将 openapi 的数据，存为 openapi.ts ，名字无所谓。

```
x-cli swagger openapi.ts
// 将生成 3 个文件  .ts .h .m
```



<img src="https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211008143502554.png" alt="image-20211008143502554" style="zoom: 50%;" />





## 请求情形

主要的区分点在于参数是在 url 里，在 header 里， 在 body 里。



GET /group

GET /group/{gid}/{uid}

GET /group/{gid}/{uid}?qa={qa}&qb={qb}



POST /group  

  +body  form-urlencody

  +body  json 

  +body formdata

  +body  stream



POST /group/{gid}/{uid}

  +body  form-urlencody

  +body  json 

  +body formdata

  +body  stream



POST /group/{gid}/{uid}

  +body  form-urlencody

  +body  json 

  +body formdata

  +body  stream
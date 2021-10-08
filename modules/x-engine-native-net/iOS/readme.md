

## KOHttp



- 基于模型自动生成网络 api
  - 强类型
  - 类型校验
- 支持 filter



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
  // request
  undefined: {
    // 操作系统（Android、IOS）
    os?: string;
    // 平台（App、POS等）
    platform?: string;
    // 版本号
    versionCode?: int;
    // 版本名称
    versionName?: string;
  };
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



使用方式：

方式 1： 基于 google 的 promise 形式

``` objc
x_api_gm_general_appVersion_checkUpdate_Req* req= [x_api_gm_general_appVersion_checkUpdate_Req new];

req.os=@"ios";
req.platform=@"ios";
req.versionCode=0;
req.versionName=@"";
id api = [x_api_gm_general_appVersion_checkUpdate new];

[[api promise:req] then:^id _Nullable(x_api_gm_general_appVersion_checkUpdate_Res * _Nullable value) {
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


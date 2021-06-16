## 目标

增加 native 路由机制。

当前仅 jsi 有依赖需求.



## 设计

由于现在的路由均由 direct 控制。只需要增加一个 direct 实现类即可。

需要复用 direct 里的参数。

打开原生界面的路由有一个问题。打开 A 与打开 B 可能界面参数不一致。

所以, 提供两种打开方式

1. 实现了原生 UI 路由接口的。
2. 由业务打开方提供 UI 界面的实例化与打开方式。





``` json
interface DirectPushDTO {
    // scheme 类型：由原生类实现
    // 当前可用:
    // 1. omp 使用 http 协议，webview 带原生 api 功能
    // 2. omps 使用 https 协议，webview 带原生 api 功能
    // 3. http 普通 webview
    // 4. https 普通 webview
    // 5. microapp 使用 file 协议，打开本地微应用文件
    scheme: string;
    // 形如  192.168.1.15:8080 
    // 要注意：
    // 1. 不需要协议名。 
    // 2. 如果有特殊端口，也必须带上
    host?: string;
    pathname: string;

    // 要注意：
    // 一定要以 / 开头
    fragment: string;
    // query 参数
    query?:Map<string, string>;

    // 其他参数（做兼容用）
  params?:Map<string, string>;
}

interface DirectBackDTO {
  // scheme 类型：由原生类实现
  // 当前可用:
  // 1. omp 使用 http 协议，webview 带原生 api 功能
  // 2. omps 使用 https 协议，webview 带原生 api 功能
  // 3. http 普通 webview
  // 4. https 普通 webview
  // 5. microapp 使用 file 协议，打开本地微应用文件
  scheme: string;
  // 要注意：
  // / 回头当前应用的首页
  // 标准路由一定要以 / 开头
  // 一些特殊字段：
  // -1 回上一页
  // 0  回头历史中的原生页
  fragment: string;
}


```



scheme: native 

host: 域名()

pathname: 类 id



参考:

https://juejin.cn/post/6844903902467342349


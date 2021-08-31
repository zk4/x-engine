

JSI Id: com.zkty.jsi.direct

version: 2.8.1



## push
[`async`](/docs/modules/模块-规范?id=jsi-调用)

**demo**
``` js

  // 跳转omp
  engine.api('com.zkty.jsi.direct', 'push',{
    scheme: 'omp',
    host: "10.2.128.80:8082",
    pathname:'',
    fragment:''
  })

  // 跳转microapp
  engine.api('com.zkty.jsi.direct', 'push', {
    scheme: "microapp",
    host: "com.zkty.microapp.mine",
    pathname: "",
    fragment: "",
  })
  
  // 跳转并删除当前页
  engine.api('com.zkty.jsi.direct', 'push', {
    scheme: "microapp",
    host: "com.zkty.microapp.mine",
    pathname: "",
    fragment: "",
    params:{
      __deleteHistory__:1
    }
  })

  // 跳转http
  engine.api('com.zkty.jsi.direct', 'push', {  
    scheme: "http",  
    host: "www.baidu.com",  
    fragment: "/",  
    pathname: "",  
  })

  // 跳转https
  engine.api('com.zkty.jsi.direct', 'push', {  
    scheme: "https",  
    host: "www.youtube.com",  
    fragment: "",  
    pathname: "",  
  })  

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| scheme | string | 必填 | omp | scheme 类型：由原生类实现<br>当前可用:<br>1. omp 使用 http 协议，webview 带原生 api 功能<br>2. omps 使用 https 协议，webview 带原生 api 功能<br>3. http 普通 webview<br>4. https 普通 webview<br>5. microapp 使用 file 协议，打开本地微应用文件 |
| host | string | optional |  | 形如  192.168.1.15:8080<br>要注意：<br>1. 不需要协议名。<br>2. 如果有特殊端口，也必须带上 |
| pathname | string | 必填 |  |  |
| fragment | string | 必填 | / | 要注意：<br>一定要以 / 开头 |
| query | Map\<string,string\> | optional |  | query 参数 |
| params | Map\<string,string\> | optional | {"hideNavbar":true} | 其他参数（做兼容用）<br>\_\_deleteHistory\_\_: -1   在push　到下一页之前，　删除掉当前页<br>\_\_deleteHistory\_\_: -2   在push　到下一页之前，　删除掉当前两页<br>历史不足时，到 tab 历史为止。<br>\_\_fallback\_\_: 'https://www.baidu.com/'   找不到路由时的 fallback |
**无返回值**



## back
[`async`](/docs/modules/模块-规范?id=jsi-调用)

**demo**
``` js

    engine.api('com.zkty.jsi.direct','back',{
     scheme: 'omp',
     fragment:'-1'
   }

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| scheme | string | 必填 |  | scheme 类型：由原生类实现<br>当前可用:<br>1. omp 使用 http 协议，webview 带原生 api 功能<br>2. omps 使用 https 协议，webview 带原生 api 功能<br>3. http 普通 webview<br>4. https 普通 webview<br>5. microapp 使用 file 协议，打开本地微应用文件 |
| fragment | string | 必填 |  | 要注意：<br>/ 回到当前应用的首页<br>标准路由一定要以 / 开头<br>一些特殊字段：<br>-1 回上一页<br>0  回到 tab 页 |
**无返回值**


    

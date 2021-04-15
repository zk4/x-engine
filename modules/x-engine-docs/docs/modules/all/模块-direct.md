

**基座扫描测试**
<div id='modulename' style='display:none'>direct</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

### RFC 规范

<br> ![RFC 规范](https://raw.githubusercontent.com/zk4/image_backup/main/img/image-20210330114053584.png)<br>

## 开发方式: 

> 为了方便业务人员的开发,我们对原生VueRouter的跳转进行了拦截.
>
> 开发人员可以直接使用VueRouter的`push()`和`go()`来进行路由的操作。
>
> npm package name:  @zkty-team/vue-router

```javascript
安装方式:
npm install @zkty-team/vue-router	
```


- 在vue项目中将以下内容放在router/index.js 即可

```javascript
import Vue from "vue"
import VueRouter from "vue-router"
import ZKTYRouter from "@zkty-team/vue-router"

// 参数1: 传入VueRouter实例
// 参数2: scheme
  // scheme说明:
  // 根据当前开发环境传入scheme:
    - omp
      - 打开线上地址的微应用 
    - http
      - 打开http的地址
    - https
      - 打开https的地址
    - microapp  
	    - 打开原生应用内部的微应用
ZKTYRouter(VueRouter, 'omp');
```

- 在页面中使用

```javascript
// 跳转指定page
this.$router.push({
	path: '/path'
})

// 回退一个页面
this.$router.go(-1)

// 回退两个页面
this.$router.go(-2)

// 返回指定页面
this.$router.go('/path') 

// 返回根页面
this.$router.go(/) 
                
// 返回根页面
this.$router.go(0) 
```



# JS


JSI Id: com.zkty.jsi.direct

version: 0.1.13



## push



**demo**
``` js
 {
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
    host: "com.gm.microapp.mine",
    pathname: "",
    fragment: "",
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
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| scheme | string | 必填 | omp |  scheme 类型：由原生类实现<br> 当前可用:<br> 1. omp 使用 http 协议，webview 带原生 api 功能<br> 2. omps 使用 https 协议，webview 带原生 api 功能<br> 3. http 普通 webview<br> 4. https 普通 webview<br> 5. microapp 使用 file 协议，打开本地微应用文件 |
| host | string | optional |  |  形如  192.168.1.15:8080 <br> 要注意：<br> 1. 不需要协议名。 <br> 2. 如果有特殊端口，也必须带上 |
| pathname | string | 必填 | / |  要注意： |
| fragment | string | 必填 |  |  要注意：<br> 一定要以 / 开头 |
| query | Map\<string,string\> | optional |  |  query 参数 |
| params | Map\<string,string\> | optional | {"hideNavbar":true} |  其他参数（做兼容用） |


---------------------
**无返回值**




## back



**demo**
``` js
 {
    engine.api('com.zkty.jsi.direct','back',{
     scheme: 'omp',
     fragment:'-1'
   }
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| scheme | string | 必填 |  |  scheme 类型：由原生类实现<br> 当前可用:<br> 1. omp 使用 http 协议，webview 带原生 api 功能<br> 2. omps 使用 https 协议，webview 带原生 api 功能<br> 3. http 普通 webview<br> 4. https 普通 webview<br> 5. microapp 使用 file 协议，打开本地微应用文件 |
| fragment | string | 必填 |  |  要注意：<br> / 回头当前应用的首页<br> 标准路由一定要以 / 开头<br> 一些特殊字段：<br> -1 回上一页<br> 0  回头历史中的原生页 |


---------------------
**无返回值**



    

# iOS


# android



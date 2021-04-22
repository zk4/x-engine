## Vue

1. 一定要先渲染 UI 骨架（或者使用占屏骨架），再异步请求网络数据。
2. 在根节点使用 keepalive, 
3. 返回上一页相当于浏览器的 goback。如果有状态要保持，需要自己保持。
4. 在使用原生路由返回时，不要触发网络刷新，而是将新数据通过 vuex, redux 或者 localstorage 模块带回历史页。
5. Router　会创建新的 web 页面，vuex 会失效。nav 会在当前页面跳转，vuex, redux 正常。
6. Router 与 Nav 模块一定要使用同步调用.
7. 在　url　传递参数时，微应用开发者必须自己对中文　URLEncode，在接受时必须自己 URLDecode。
8. 除非微应用是由原生应用打开，否则，不要依赖　uri 的参数替换。微应用内部应该保持参数的正确。不应该通过未定参数调用　router　或 nav。引擎将不予处理。
9. 在不使用原生 navbar , 而选择自己手写时, 一定要引入 device 模块取得 statusbar 的高度让出安全距离.

---

## 

## 框架搭建

### x-engine-core

- 连接h5和native的重要桥梁,一切操作都从该文件转发
- 所以`x-engine-core`务必安装

1. 安装方式

```bash
npm install @zkty-team/x-engine-core
```

2. 安装后挂载在Vue上使用, 在main.js中配置以下code

```bash
import engine from "@zkty-team/x-engine-core"
Vue.prototype.$engine = engine;
```

3. 配置成功后即可在全局通过`this.$engine.api`去触发原生相关模块

```javascript
// 示例
this.$engine.api(
	"com.zkty.jsi.device",
	"getNavigationHeight"
)
```

---

### x-engine-router

- 为了方便业务人员的开发,我们对原生VueRouter的跳转进行了拦截.
- 开发人员可以直接使用VueRouter的`push()`和`go()`来进行路由的相关操作。

1. 安装方式:

```bash
npm install @zkty-team/x-engine-router
```

2. 在vue项目中将以下内容放在router/index.js 即可

```javascript
// 示例
import Vue from "vue"
import VueRouter from "vue-router"
import XEngineRouter from " @zkty-team/x-engine-router"

// 参数1: 传入VueRouter实例
// 参数2: scheme
  // scheme说明:
  // 根据当前开发环境传入scheme:
    1- omp 测试用
      1.1- 打开线上地址的微应用 
    2- http
      2.1- 打开http的地址
    3- https
      3.1- 打开https的地址
    4- microapp  
	    4.1- 打开原生应用内部的微应用
if (process.env.NODE_ENV == 'development') {
    XEngineRouter(VueRouter, 'omp');    
} else {
    XEngineRouter(VueRouter, 'microapp');
}
```

3. 配置成功后即可使用VueRouter的跳转方式进行跳转相关的操作

    [详细参考](./docs/modules/all/模块-direct.md)



## 
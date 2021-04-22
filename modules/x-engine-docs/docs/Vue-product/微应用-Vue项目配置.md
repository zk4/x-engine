### 各组Leader进行以下项目配置

- 统一前端开发工具 vscode

- 统一前端格式化规范 ESLint

- 配置好webpack打包工具

      

### 1. vue-cli创建vue项目
	- VueX
	- VueRouter

### 2.axios发送网络请求

- 统一所有业务人员使用一种方式进行网络请求(是否需要考虑原生网络拦截, 待做)

### 3. x-engine-core

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

### 4. x-engine-router

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
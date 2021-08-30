### RFC 规范

<br> ![RFC 规范](https://raw.githubusercontent.com/zk4/image_backup/main/img/image-20210330114053584.png)<br>

## 开发方式

> 为了方便业务人员的开发,我们对 h5 的跳转进行了拦截.
>
> 开发人员可以直接使用vue-router的`push()`和`go()`来进行路由的操作。
>

```javascript
安装方式:
npm install @zkty-team/x-engine-router
```


- 在vue项目中将以下内容放在router/index.js 即可

```javascript
import Vue from "vue"
import VueRouter from "vue-router"
import XEngineRouter from " @zkty-team/x-engine-router"

// 参数1: 传入VueRouter实例
// 参数2: scheme
// scheme说明:
// 根据当前开发环境传入scheme:
//  - omp
//    - 打开线上地址的微应用 
//  - http
//    - 打开http的地址
//  - https
//    - 打开https的地址
//  - microapp  
//    - 打开原生应用内部的微应用
if (process.env.NODE_ENV == 'development') {
    XEngineRouter(VueRouter, 'omp');    
} else {
    XEngineRouter(VueRouter, 'microapp');
}
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

// 返回微应用根页面
this.$router.go(/) 
                
// 返回nativeApp根页面
this.$router.go(0) 
```


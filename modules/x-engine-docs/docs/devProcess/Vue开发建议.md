并不是说只能用 vue 开发, jsi api 只是普通的 js 调用. 只不过我们提供了一些较为方便的 vue 兼容包.你完全可以不依赖 vue 开发. 直接使用 jsi api 来做 hybrid 开发.



template 工程地址: https://github.com/zkty-team/vue-template



## 生命周期

template 工程地址: https://github.com/zkty-team/vue-template

! 生命周期将会回调当前页面所有的注册过的web页面.这个要特别注意. 比如: 你在当前 web 里有 5 个组件,都在 methods 里写了 onNativeShow 那就会有 5 次回调.

``` js
const ON_NATIVE_SHOW = "onNativeShow"; // 原生显示, 有可能 webview 还没有加载完成。 需要自行判断
const ON_NATIVE_HIDE = "onNativeHide"; // 原生隐藏
const ON_NATIVE_DESTROYED = "onNativeDestroyed"; // 原生销毁
```

1. 安装方式:

```bash 
npm install @zkty-team/x-engine-lifecycle
```

2. 在vue项目中将以下内容放在main.js 即可 ·

```javascript
import lifeCycle from "@zkty-team/x-engine-lifecycle";
Vue.use(lifeCycle);
```

3. 使用方式 在每个页面中的methods中实现对应function即可

```javascript
methods: {
  onNativeShow() {},
  onNativeHide() {},
  onNativeDestroyed() {},
}
```



---

## vue-router 兼容

- 为了方便业务人员的开发,我们对原生VueRouter的跳转进行了拦截.
- 开发人员可以直接使用VueRouter的`push()`和`go()`来进行路由的相关操作。
- 支持query传递参数
- 支持params传递参数

---

1. 安装方式:

```bash
npm install @zkty-team/vue-router
```

2. 在vue项目中将以下内容放在router/index.js 即可

```javascript
// 示例
import Vue from "vue"
import VueRouter from "@zkty-team/vue-router"
Vue.use(VueRouter)
```
**值得注意的是**
> 我们支持 'omp','omps' 和 'microapp' protocol, 如果你的页面打开是'http' 那么protocol便是'omp',打开是'https' 那么protocol便是'omps'.<br>
```javascript
import Vue from "vue"
import VueRouter from "@zkty-team/vue-router"
Vue.use(VueRouter)
```
> 当然我们也支持手动传入protocol, 例如:
```javascript

import Vue from "vue"
import VueRouter from "@zkty-team/vue-router"
Vue.use(VueRouter, 'omp')
```
3. 配置成功后即可使用VueRouter的跳转方式进行跳转相关的操作 [详细参考](./docs/modules/all/模块-direct.md)
> tips:
>
> router配置中请设置为相同的path和name 如下

```javascript
const routes = [
  {
		path: "/testPage",
		name: "testPage",
	  component: () => import('../views/testPage.vue'),
  }
]
```

---

## vuex 兼容

由于 microapp 容器里的每一页都是在新的 webview 里, 传统的 vuex 是不会生效的.我们为 vuex 做了一定的兼容. 现在仅是可用. 性能完全没考虑.

1. 安装方式:

```bash
npm install @zkty-team/vuex
```

2. 在vue项目中将以下内容放在main.js 即可 ·

```javascript
import store from "./store"
new Vue({
  store,
  render: (h) ==>h(App),
}).$mount("#app");
```

3. 在store的index中配置以下内容
```javascript
import Vue from 'vue'
import Vuex from '@zkty-team/vuex'
Vue.use(Vuex)
const store = new Vuex.Store({
    state: {
        count: 0,
    },
    mutations: {
        increament (state) {
            state.count++
        },
        decreament (state) {
            state.count--
        },
    },
    actions: {},
	  getters:{}
})
export default store
```

---

#### 什么情况下我应该使用 Vuex？

Vuex 可以帮助我们管理共享状态，并附带了更多的概念和框架。这需要对短期和长期效益进行权衡。

如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex。一个简单的 [store 模式 (opens new window)](https://cn.vuejs.org/v2/guide/state-management.html#简单状态管理起步使用)就足够您所需了。但是，如果您需要构建一个中大型单页应用，您很可能会考虑如何更好地在组件外部管理状态，Vuex 将会成为自然而然的选择。引用 Redux 的作者 Dan Abramov 的话说就是：

> Flux 架构就像眼镜：您自会知道什么时候需要它。

 [Vuex官方使用方式](https://vuex.vuejs.org/zh/guide/)





##  header 适配

- 基于Vue的仿原生导航条
- 完美支持Android和iOS上导航条高度
- 通过@zkty-team/vue-router中的meta传递信息
- 使用`Header`,开发人员不用在每个页面都配置一次，主需要在配置router的信息的时候配置好要展示的内容即可。

#### 安装方式

```bash
npm install @zkty-team/x-engine-ui
npm install @zkty-team/vue-router
```

#### 使用方式

**配置在main.js中**

```javascript
import Header from '@zkty-team/x-engine-ui';
import "@zkty-team/x-engine-ui/lib/Header.css"
Vue.use(Header);
```

**配置在App.vue中**

```vue
<div id="app">
	<Header />
	<router-view :style="style" />
</div>

<script>
export default {
  name: "App",
  data() {
    return {}
  },
  computed: {
    style() {
      let style;
      let statusBarHeight = this.$statusHeight;
      let navheight = this.$navigatorHeight;
      if (navheight == undefined && statusBarHeight == undefined) {
        style = `margin-top:${64}px;`
      } else {
        let height = Number(statusBarHeight) + Number(navheight)
        style = `margin-top:${height}px`
      }
      return style
    },
  },
}
</script>
```

**在`router`的`meta`中配置相关信息**

```javascript
// 示例
{
  path: "/",
  name: "Home",
  meta: { 
    title: "首页",
    bgColor: "#ddd",
    customBgcImg: require('@/static/image/navBJ.png'),
    backPath: 0
  },
  component: () => import('../views/Home.vue'),
 },	
```

**参数说明**

| name         | type    | optional | default | comment                                                   |
| ------------ | ------- | -------- | ------- | --------------------------------------------------------- |
| title        | string  | 必传     | 返回    | 导航条文字                                                |
| bgColor      | string  |          | #fff    | 背景色、支持16进制、支持颜色英文、透明传入transparent即可 |
| customBgcImg | string  |          | ""      | 背景图片、 需要通过require()进行动态加载                  |
| backPath     | string  |          | -1      | 返回路径, 默认返回上一层页面 、支持数字、支持"/xxx"、     |
| isShowHeader | Boolean |          | false   | 是否隐藏导航条、 配合自定义导航条使用                     |
| textIsCenter | Boolean |          | false   | 默认在左边显示，传true在中间显示                          |
| isWhiteColor | Boolean |          | false   | 默认文字和图片为#000, 如果需要改成白色传true              |



#### tip:

- 动态修改title: 
  - 有的时候下一个页面的title不是固定配置在`meta`信息中的而是从接口中获取的title值
- 那么你需要在到下个页面的时候通过push的方法来修改title的信息
  - 但是title必须配置, 你可以随便传个值
- 通过以下方式来修改即可

```vue
this.$router.push({
  query: {
		changeNavTitle: "navTitle",
	},
})
```

- 动态修改backPath

  - 有的时候返回的页面可能不是-1 是之前的某个页面
  - 那就在你要返回的页面中修改`meta`中的`backPath`即可

```js
this.$route.meta.backPath = 0	
```

---



### 重写Header

- 由于`Header`提供了相关的配置信息, 但是一些样式复杂的页面样式需要业务人员自己创造
- `Header`暴露的了3个slot供开发人员编写复杂的符合页面的样式
- slot名称
  - left
  - center
  - right



- 在`router`的`meta`中配置隐藏当前页面的导航条

```javascript
// 示例
{
  path: "/",
  name: "Home",
  meta: { 
    isShowHeader : true
  },
  component: () => import('../views/Home.vue'),
 },    	
```

- 在page中编写符合页面的样式即可。
- 3个slot根据页面的样式进行选择编写，也可能只用一个slot 或者二个slot 或者三个slot都用上。

```vue
<Header :bgColor="bgColor">
	<template v-slot:left>
		<div @click="handlerLeft">我是返回</div>
	</template>
	<template v-slot:center>
		<div @click="handlerCenter">我是搜索框</div>
	</template>
	<template v-slot:right>
		<div @click="hanlderRight">右边按钮</div>
	</template>
</Header>
```


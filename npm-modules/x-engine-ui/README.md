## x-engine-ui

- 前端公共组件库

### 1. x-engine-header

- 基于 Vue 的仿原生导航条
- 完美支持 Android 和 iOS 上导航条高度
- 支持修改颜色
- 支持修改文字
- 支持修改背景图
- 支持自定义返回事件
- 通过 vueRouter 中的 meta 传递信息
- 支持重写
- 支持内置插槽 slot
- slotName --> left
- slotName --> center
- slotName --> right

安装方式

```javascript
import Header from "@zkty-team/x-engine-header";
import "@zkty-team/x-engine-header/lib/Header.css";
Vue.use(Header);
```

使用方式

配置在 App.vue 中. 全局即可显示

```javascript
<div id="app">
  <Header />
</div>
```

​

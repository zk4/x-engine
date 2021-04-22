## x-engine-ui

- 前端公共组件库



### 1. x-engine-header

- 基于Vue的仿原生导航条
- 完美支持Android和iOS上导航条高度
- 支持修改颜色
- 支持修改文字
- 支持修改背景图
- 支持自定义返回事件
- 通过vueRouter中的meta传递信息
- 支持重写
- 支持内置插槽slot
 - slotName --> left
 - slotName --> center
 - slotName --> right

安装方式

```javascript
import ZKTYHeader from '@zkty-team/x-engine-header';
import "@zkty-team/x-engine-header/lib/ZKTYHeader.css"
Vue.use(ZKTYHeader);		
```



使用方式

配置在App.vue中. 全局即可显示

```javascript
<div id="app">
	<ZKTY-Header />
	<router-view :style="style"/>
</div>
```






​    


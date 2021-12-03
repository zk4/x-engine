## x-engine-core (必装)


- 连接h5和native的重要桥梁,一切操作都从该文件转发
- 所以`x-engine-core`务必安装

---

1. 安装方式

```bash
npm install @zkty-team/x-engine-core
```

2. 安装后挂载在Vue上使用, 在main.js中配置以下code

```bash
import xengine from "@zkty-team/x-engine-core"
Vue.use(xengine)  // Vue 要选 配置成功后即可在全局通过`this.$engine.api`去触发原生相关模块
```

3. 使用

```javascript
// 同步调用示例
xengine.api("com.zkty.jsi.device",	"getTabbarHeight",{})

// 异步调用示例(异步的方法参考详细模块调用)
xengine.api("com.zkty.jsi.device",	"getTabbarHeight",{}, function (res) {
	 console.log("res :>> ", res)
})
```


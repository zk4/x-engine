 

## 类图



比如 Open 功能，我们可以实现 OpenH5Module，OpenNativeModule，OpenMicroAppModule。 

在 JSIOpenModule 里，在 afterAllNativeMouduleInited 回调生命周期里，可以调用引擎 EngineContext::getNativeModulesByInterface(iOPen);

即可以拿到 iOpen 的所有实现。将它们填加进 JSIOpenModule 里即可完成动态注入原生模块功能。

而当原生需要这些功能时

![image-20210323131608140](assets/image-20210323131608140.png)



- 引擎模块： 

  - 可替换为任意开源的优秀模块管理类

- model.ts 自动生成：

  将由 model.ts 通过 x-cli 生成

  i 代表 interface

  a 代表 abstract class

  JSI 代表 Javascript Interface

  > 要注意，在 iOS 里，扫描的是 aJSIOpen。 个中原因，oc 语言不支持重载。

- JSI 实现

  实现带下划线的抽象类方法

- 接口 与 iOpen 实现

  这两者可以独立由原生模块机制管理。


![cooltext363596337964428](assets/cooltext363596337964428.png)

# X-engine 简介

x-engine 是一个跨端模块管理框架，它的定位就是是客户端的 spring，管理 bean（模块）。当前主要服务于产品 MicroApp

![image-20200929021827767](assets/image-20200929021827767.png)

x-engine 的目的并不是做“另一个跨平台”框架，

因为这样的框架太多了，从时间上，先是 cordova/capacitor，到 react-native, 到 flutter。

总结下来就这几种模式：

native + h5  : cordova 

h5 -> native  : reactie-native  weex 

self-render   : flutter

native + web- : 小程序

这些模式普遍都有一个"特性", 绑定 UI 框架。这给某些已存在的 UI 技术栈的集成带来了一定的困难。 如果仅仅是尝尝鲜，那对他们的集成与扩展又会是一件非常麻烦的事。

x-engine 可以在一定程度上解决选择困难症的问题。 怎么快速切换，组合模块是 x-engine 要解决的问题。

通过模块的组合，我们可以快速复用已有的 hybrid 框架，甚至还可以自造一个 hybrid 框架。比如 MicroApp 



## MicroApp

它是一套基于 x-engine 的 Hybrid 轻量解决方案。 通过几个模块的简单组合,就能使你的 app 具有微信小程序的能力. 

支持的功能包含：

- 离线更新.
- 只绑定 js, 不 绑定 ui.
- 统一路由，等等。

如果你觉得某个微应用开发的业务动效不如你预期，你甚至可以切换到 react-native 模块重新开发这个业务，且能与其他的微应用共存。



x-engine 并不会试图再去造一套 “小程序” DSL，而是可以根据业务需求, 快速模块化. 

这也意味着 Vue，React，Angular 任何 H5 / SPA 的开发框架都可以是我们选型对象。 

x-engine 将会全面开源，包括核心源码。在出问题时，你能跟踪到任何一端直到不属于我们的源码。 





# 资源地址

引擎: [iOS](https://github.com/zkty-team/x-engine-module-engine/tree/master/iOS) [android](https://github.com/zkty-team/x-engine-module-engine/tree/master/android)

微应用模板:[hybrid-tempalte](https://github.com/zkty-team/x-engine-hybrid-template)

模块模板:[module-template](https://github.com/zkty-team/x-engine-module-template)

基座下载地址 [ios](https://www.pgyer.com/ZCfP) / [android](https://www.pgyer.com/BUBN) (基座集成了部分组件,可供开发使用)

包含:


module-nav
module-localstorage
module-network
module-ui
module-router
module-scan



# 项目管理

https://zktyfe.worktile.com/tasks/projects/5f164ffa478dbd1d67107712


![](assets/cooltext363596337964428.png)

# X-engine 简介

x-engine 是一个跨端模块管理框架.
只做一件事，<span style="color:blue">管理原生模块(iOS/android)</span>。 

围绕这个功能有一系列的自动化: 工程结构, 文档生成. 代码生成. 自动注册.等. 


<!-- tabs:start -->

#### **架构图**

![](assets/image-20210422162652052.png)

#### **类图**

![](assets/image-20210422162839624.png)


<!-- tabs:end -->




x-engine 可以与各种跨平台框架融合.


跨平台框架: 总结下来就这几种模式：

native + h5  : cordova 

h5 -> native  : reactie-native  weex 

self-render   : flutter

native + web- : 小程序

没有谁好谁坏, 但在选择某个方案前,你都得关注这几个点:

项目目标, 可维护性, 可扩展性, 可协作性, 开发效率, 开发人员门槛, 开发技术的隔离.

cordova/capacitor/ionic 的问题在于, 它是以 h5 为主.原生为辅. 这就让原生很尴尬,最终会沦为插件转换器. 但 h5 也很尴尬,只要涉及到原生.完全摸不着北.

reactie-native  的问题在于, 它丢弃了 h5 很多东西. 如果你真又要开发效率又要原生性能.也许是个不错的选择.

flutter 就是更尴尬. 半路出家的 native 开发者去玩 flutter. 总有一种突然能先写两端的幻觉. 但出问题能不能 hold 住是个非常大的问号. 能不能 google 到答案基本是 99% flutter 开发人员的上限.




x-engine 的优势在于, 原生为主. 由原生主导. 充分利用社区已存在的功能.

x-engine 以 sdk 的形式集成. 而其他跨平台框架会以 sdk 的插件集成.也就代表对原生工程不会有侵入性. 






# 外部资源
[ve-charts](https://vueblocks.github.io/ve-charts/#/chart-wordcloud)

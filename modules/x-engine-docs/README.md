<img src="assets/image-20210522170631443.png" alt="image-20210522170631443" style="center:true;zoom:50%;" />

# X-engine 简介

x-engine 是一个跨端模块管理框架. <span style="color:blue">管理原生模块(iOS/android)</span>。 所有功能特性均由模块支撑。

通过 x-engine  我们提供一整套完善的前端解决方案。 

你可以基于 x-engine 开发纯原生 App。

也可以基于 x-engine 开发 react-native，weex,flutter,h5 与原生的混合。也就是集成任何可在原生上表现的 UI 框架。



app = UI + 逻辑。

UI 层在最终呈现时，现在主流有 4 种方案.x-engine 都可以支持.

1. 原生语言 -> 原生布局引擎 -> 原生绘制引擎  -> UI
2. 自定义语言 -> 浏览器布局引擎 -> 浏览器绘制引擎  -> UI，常见于 hybrid 方案
3. 自定义语言 -> 自定义布局引擎 -> 原生绘制引擎     -> UI，常见于 RN / weex 等这种方案
4. 自制引擎    -> 自定义布局引擎 -> 自定义绘制引擎  -> UI，常见于 flutter, crossapp 这种方案



<img src="assets/image-20210524125334634.png" alt="image-20210524125334634" style="zoom:40%;" />



原生 UI 层社区如此繁荣。再造轮子就没必要了。 那我们前端解决方案的目标就比较清晰。

2. UI 模块间无缝路由。
3. UI 模块能复用 Native Api。
4. 提供快速开发范式与兼容方案。
4. 保障模块的安全，保障性能。



<!-- tabs:start -->

## **架构图**



![image-20211026010158237](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211026010158237.png)

#### **类图**

![](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/design-compatiable.png)


<!-- tabs:end -->

  

## 举例: RN container api 调用

RN Container 调用原生相机

![](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/image-20211018132618053.png)

 

> 其中RNCamera 就是原始的 RN 原生模块.由 RNContext 自己管理. 但 RN Camera 的实现由 Native 模块统一管理.

## 小程序呢

小程序的支持不应该由 x-engine 解决。而应该由 UI 方案自己解决。比如，基于 taro，vant-weapp。




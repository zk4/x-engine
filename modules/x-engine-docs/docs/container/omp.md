omp 容器为  online microapp 的缩写. 也就是 h5 拥有本地 api 的功能.  
路由以 omp: omps: microapp: 开头



omp / omps 容器支持在线 h5 + native api的能力。

并带有开箱即用的一些有用特性。



## 缓存

缓存是会拦截 http, https 的请求，现在默认是缓存图片。js，以及 css 等资源性文件。

同时也解决了 iOS 里 wkwebview 在 post 里会丢失 body 的问题。

见 x-engine-jsi-webcache 与 x-engine-native-webcache 模块。

详见： [分发与缓存](./docs/modules/分发与缓存)

## 路由

路由是基于接口设计，所以，你可以路由到你想到去的任何容器。

见 x-egnine-native-direct x-egnine-native-direct_omp  x-egnine-native-direct_omps x-egnine-native-direct_microapp 模块。

详见： [分发与缓存](./docs/modules/分发与缓存)

## 热更

见 x-egnine-native-updator 模块。

详见： [分发与缓存](./docs/modules/分发与缓存)


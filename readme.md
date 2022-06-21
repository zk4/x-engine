另一个简单的 iOS /android 模块管理框架. 支持混合应用开发，任意 UI 方案的混合。

如果你只想混合 h5. 

jsi-* 与 native-jsi 模块可帮助你快速开发 h5 混合应用。详细可参看文档。

如果你想混合 flutter/rn/weex.

实现 idrect 接口即可。

文档: http://x-engine-1257400556.cos-website.ap-guangzhou.myqcloud.com



文档包含两部分，api 文档与手写文档，

1. api 文档

由 model.ts 生成 readme.md。

最终要放到 x-engine-docs 里，

可以通过 x-engine-docs/gen_readme.py 做这件事，gen_readme.py

在运行 gen_readme.py 前，先在 x-engine 执行 yarn install 

2. 手写文档维护在 x-engine-docs



到 x-engine/modules 下，执行 serverless，即可发布文档。当然，需要 serverless 服务管理员权限。





``` 
├── Makefile
├── devTools
│   ├── motherboard-android
│   ├── motherboard-iOS
├── modules
│   ├── x-engine-app
│   ├── x-engine-docs              
│   ├── x-engine-jsi-broadcast
│   ├── x-engine-jsi-camera
│   ├── x-engine-jsi-dev
│   ├── x-engine-jsi-device
│   ├── x-engine-jsi-direct
│   ├── x-engine-jsi-geo
│   ├── x-engine-jsi-globalstorage
│   ├── x-engine-jsi-legacy
│   ├── x-engine-jsi-localstorage
│   ├── x-engine-jsi-scan
│   ├── x-engine-jsi-secret
│   ├── x-engine-jsi-share
│   ├── x-engine-jsi-store
│   ├── x-engine-jsi-template
│   ├── x-engine-jsi-ui
│   ├── x-engine-jsi-viewer
│   ├── x-engine-jsi-vuex                // vuex 兼容模块
│   ├── x-engine-jsi-webcache            // 网络兼容模块
│   ├── x-engine-native-camera           // 相机模块
│   ├── x-engine-native-core             // 模块管理模块
│   ├── x-engine-native-direct           // 路由管理模块
│   ├── x-engine-native-direct_http      // http 路由模块
│   ├── x-engine-native-direct_https     // https 路由模块
│   ├── x-engine-native-direct_microapp  // 微应用路由模块
│   ├── x-engine-native-direct_native    // 原生路由模块
│   ├── x-engine-native-direct_omp       // omp 路由模块
│   ├── x-engine-native-geo              // 通用地理位置模块
│   ├── x-engine-native-geo_gaode        // 高德地理位置模块
│   ├── x-engine-native-jsi              // jsi 模块
│   ├── x-engine-native-protocols        // 协议模块
│   ├── x-engine-native-scan             // 通用扫码模块
│   ├── x-engine-native-scan__hms        // 华为扫码模块
│   ├── x-engine-native-share            // 通用分享模块
│   ├── x-engine-native-share_wx         // 微信分享模块
│   ├── x-engine-native-store            // 通用存储模块
│   ├── x-engine-native-tabbar           // tabbar 兼容模块
│   ├── x-engine-native-updator          // 在线更新模块
│   ├── x-engine-native-viewer           // 通用文档查看模块
│   ├── x-engine-native-viewer_original  // 原生文档查看模块
│   └── x-engine-native-webcache         // 网络缓存模块

```

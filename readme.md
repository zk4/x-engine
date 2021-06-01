1. 使用 lerna 统一管理版本。参看 lerna 官方教程。
1. 使用 yarn workspace 统一管理依赖。参看 yarn workspace。

## 开发
2. 原生模块，分为 native 与 JSI 类，(module 弃用)，模块均可通过 x-cli 快速生成与测试。

## demo
## 项目结构
```
├── devTools　引擎工具
├── microApps    demo h5
├── npm-modules  x-engine npm 模块
├── scripts  git 日志校验
├── modules　引擎模块
	├── Makefile
	├── serverless.yml
	├── x-engine-docs　             （技术文档源码）
	├── x-engine-native-*　         （原生模块）
	├── x-engine-jsi-*　　　        （jsi模块）

```

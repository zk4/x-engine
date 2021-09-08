比如你要集成 flutter 容器到引擎

你只需要实现在源码工程 modules/x-engine-native-protocols 里的 idrect 接口即可。

1. 生成工程
``` 
coge x-engine-native-template  xxxx:rn @x-engine-native-direct_flutter
```

2. 在 Native\_flutter 模块类的生命周期里初始化 flutter 引擎。生命周期并没有直接回调，写法可参考 store 模块。

3. 实现 idrect 接口 


完事。 



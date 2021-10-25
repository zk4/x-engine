需要原生安装相应的jsi 模块, 即可使用 [JSI api](./docs/modules/all/模块-device.md)


```
// 同步方法
let ret = xengine.api(<JSI 模块名id>,<方法名>,参数)
// 异步方法
xengine.api(<JSI 模块名id>,<方法名>,参数,(ret)=>{})
```


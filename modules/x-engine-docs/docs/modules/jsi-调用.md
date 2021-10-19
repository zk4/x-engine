## JSI 调用

需要原生安装相应的 JS module,以实现调用


```
// 同步方法
let ret = xengine.api(<JSI 模块名id>,<方法名>,参数)
// 异步方法
xengine.api(<JSI 模块名id>,<方法名>,参数,(ret)=>{})
```



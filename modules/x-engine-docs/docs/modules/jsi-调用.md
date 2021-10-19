## JSI 调用

需要安装相应的 JS module,以实现调用. 一般用在微应用环境.

如, 直接使用即可

```
// 同步方法
let ret = xengine.api(<JSI 模块名id>,<方法名>,参数)
// 异步方法
xengine.api(<JSI 模块名id>,<方法名>,参数,(ret)=>{})
```



## JSI 调用

需要安装相应的 JS module,以实现调用. 一般用在微应用环境.

如, 直接使用即可

```
// 同步方法
let ret = xengine.api(<JSI 模块名id>,<方法名>,参数)
// 异步方法
xengine.api(<JSI 模块名id>,<方法名>,参数,(ret)=>{})
```



## scheme 调用

一般用在 h5 里, 

```
x-engine-call://{JSI_module_id}/{method}?args={args}&callback={callbackurl}
```

{moduleName} 全模块名, 如 com.zkty.module.camera, 见各模块帮助文档
{args} 为 urlencode 过的　json　**String**
{callbackurl} 由调用者指定(必须urlencode), 

如 

```
https://dev-mall-linli.timesgroup.cn/H5/#/orderDetail?orderType=20&parentOrderNum=PLLB201228000000049&orderId=1060170&ret={ret}
```

{ret} 将被替换为返回值. {ret} 为 urlencode 过的　json　**String**

在拿到返回值后, 在当前页面打开 {callbackurl}

如:

```
https://dev-mall-linli.timesgroup.cn/H5/#/orderDetail?orderType=20&parentOrderNum=PLLB201228000000049&orderId=1060170&ret=%7B%0A%20%20%22billRetStatus%22%20%3A%201%2C%0A%20%20%22billRetStatusMessage%22%20%3A%20%22%E6%94%AF%E4%BB%98%E6%88%90%E5%8A%9F%22%2C%0A%20%20%22isCancel%22%20%3A%20false%0A%7D
```


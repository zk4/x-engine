


broacast 当前仅供原生主动使用,会广播各种 type, 如 vuex 当前依赖了 broadcast
如果业务有用到,需要定义好 type,与 payload. 前端使用如下

```
xengine.broadcastOn((type, payload) => {
  if (type === 'xxxxx') {
    console.log(type, payload)
  }
})
```



JSI Id: com.zkty.jsi.broadcast

version: 3.0.3



    


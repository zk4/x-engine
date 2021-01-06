
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-router
```



## openTargetRouter

跳转页面.

**demo**
``` js
 {
  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"http://192.168.10.51:8081/index.html", path:"" })
      .then((res) => { });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 | h5 | 跳转类型 |
| uri | string | 必填 | http://192.168.10.51:8081/index.html | 跳转目标 |
| path | string | 必填 |  | 跳转参数 |
| args | Map\<string,string\> | optional |  | 其他参数 |
| version | int | optional |  |  |
| hideNavbar | bool | optional |  |  是否隐藏navbar, 默认 false |

**返回值**
**无参数**



    
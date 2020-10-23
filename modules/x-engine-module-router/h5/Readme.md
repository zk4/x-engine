
``` bash
npm install @zkty-team/com-zkty-module-router
```



## openTargetRouter

跳转页面.

**demo**
``` js
 {
  window.openTargetRouter = () => {
    router
      .openTargetRouter({ type: "h5", uri:"https://www.baidu.com", path:"" })
      .then((res) => { });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  | h5 | 跳转类型 |
| uri | string |  | https://www.baidu.com | 跳转目标 |
| path | string |  |  | 跳转参数 |

    
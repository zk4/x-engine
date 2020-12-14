

**基座扫描测试**
<div id='modulename' style='display:none'>router</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.0.60
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
| type | string |  | h5 | 跳转类型 |
| uri | string |  | http://192.168.10.51:8081/index.html | 跳转目标 |
| path | string |  |  | 跳转参数 |
| args | Map\<string,string\> | true |  | 其他参数 |
| version | int | true |  |  |

    

# iOS


# android



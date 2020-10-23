

**基座扫描测试**
<div id='modulename' style='display:none'>localstorage</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

localstorage 会根据微应用的 appid 自动加入 namespace.

也可以向全局写入, 用于应用间的数据共享.

微应用A 无法访问微应用 B的数据.








# JS


``` bash
npm install @zkty-team/com-zkty-module-localstorage
```



## set



**demo**
``` js
 {
  window.set = () => {
    localstorage
      .set({
        key: "key",
        value: "value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string |  | key | 存储设置key值 |
| value | string |  | value | 存储设置value值 |
| isPublic | bool |  |  | 是否数据共享 |


## get



**demo**
``` js
 {
  window.get = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string |  | key | 要获取的存储值的key值 |
| isPublic | bool |  |  | 要获取的存储值是否是共享数据 |


## remove



**demo**
``` js
 {
  window.remove = () => {
    localstorage
      .remove({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string |  | key | 要删除的存储值的key值 |
| isPublic | bool |  |  | 要删除的存储值是否是共享数据 |


## removeAll



**demo**
``` js
 {
  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isPublic | bool |  |  |  |

    

# iOS


# android



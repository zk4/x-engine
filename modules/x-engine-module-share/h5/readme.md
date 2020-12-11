
version: 0.0.59
``` bash
npm install @zkty-team/x-engine-module-share
```



## share



**demo**
``` js
 {
  window.share = () => {
    share
      .share({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  | link |  (music,video,link) 不填默认为link |
| title | string |  | test |  |
| desc | string |  | testdesc |  |
| link | string |  | http://www.baidu.com |  |
| imgUrl | string |  |  |  |
| dataUrl | string | true |  |  如果type是music或video，则要提供数据链接，默认为空 |
| \_\_event\_\_ |  | true | (string)=>string |  |

    
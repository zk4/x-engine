

JSI Id: com.zkty.jsi.viewer

version: 0.1.13



## openFileReader
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 打开文件
**demo**
``` js

      xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf","fileType":"pdf","title":"用户协议"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
            console.log(JSON.stringify(val)
    });  

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| fileUrl | string | 必填 |  | 文件地址 |
| fileType | string | 必填 |  | 文件类型，指定文件类型打开文件 |
| title | string | 必填 |  | title 展示使用 |
**返回值**
``` js



//打开的回调 扩展使用 
interface StatusDTO {

  //状态信息返回
  resultMsg: string;

}
``` 


    
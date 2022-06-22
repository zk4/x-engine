

JSI Id: com.zkty.jsi.browser

version: 3.0.7



## open
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 使用系统浏览器打开url


> **demo**
``` js
 {
  xengine.api("com.zkty.jsi.browser", "open",{
        "url":"",
 
    } ,(val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 链接地址 |

**返回值**
``` js
 {

  // 状态码
  // code = 0  成功
  // code = -1 失败
  code: int;
  // 函数状态描述（比如找不到系统浏览器，链接解析失败等）
  msg: string;

}
``` 


    
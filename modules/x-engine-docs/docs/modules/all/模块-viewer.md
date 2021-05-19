





JSI Id: com.zkty.jsi.viewer

version: 0.1.13



## openFileReader
[`sync`](/docs/modules/模块-规范?id=jsi-调用),[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 打开文件
**demo**
``` js

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {
    filePath: "xxx",
    fileName: "协议.pdf"}, (val) => {
      console.log(JSON.stringify(val)
    )}
  );    

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| filePath | string | 必填 |  | 文件地址 |
| fileName | string | 必填 |  | 文件名称 |
**返回值**
``` js


//返回参数
interface StatusDTO {

  //状态信息返回
  result: string;

}
``` 


    


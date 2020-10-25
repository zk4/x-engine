

**基座扫描测试**
<div id='modulename' style='display:none'>network</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

# 统一网络

网络是除缓存外最核心的一块功能. 

需要将 h5 的网络统一由 native 做一层代理, 来解决 cookie 共享, 安全, 跨域, 缓存, 路由等问题.

浏览器本身自带的网络请求功能, 只做加载第三方链接的标签资源用. 要达到如微信小程序的感觉, 可直接屏蔽.

其他请求全必须走本地网络.

方案会基于异步封装 native 网络请求.

![d1bea368-81fb-4ef3-b069-5695c2a61fc9](assets/d1bea368-81fb-4ef3-b069-5695c2a61fc9-5236402.png)

**白名单**

统一网络出口要设白名单， 防止xss。

白名单配置在服务器上。在下载离线包时，读入配置。

配置做签名，防止篡改。 统一网络




# JS


``` bash
npm install @zkty-team/com-zkty-module-network
```



## getRequest

 interface UploadReponseDTO {
     //返回状态
     status: int;
     //返回头
     headers: Map<string, string>;
     //返回请求体
     request?: UploadRequestDTO;
     //返回结果
     data: string
 }
发送GET网络请求
**demo**
``` js
network.getRequest({
   url: 'https://api.mocki.io/v1/b043df5a',
   method: 'get',
}).then((res) => {
  console.log(res)
});
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## postRequest

发送POST网络请求 
 **demo**
 ``` js
 network.postRequest({
    url: 'http://lihong.utools.club/api/user/login',
    method: 'post',
    params: {
      username: 'admin',
      passwork: 'e10adc3949ba59abbe56e057f20f883e'
    }
 }).then((res) => {
   console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## deleteRequest

发送DELETE网络请求 
 **demo**
 ``` js
 network.deleteRequest({
    url: 'https://api.mocki.io/v1/b043df5a',
    method: 'delete',
 }).then((res) => {
   console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## headRequest

发送HEAD网络请求 
 **demo**
 ``` js
 network.headRequest({
    url: 'https://api.mocki.io/v1/b043df5a',
    method: 'head',
 }).then((res) => {
   console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## putRequest

发送PUT网络请求 
 **demo**
 ``` js
 network.putRequest({
    url: 'https://api.mocki.io/v1/b043df5a',
    method: 'put',
 }).then((res) => {
   console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## patchRequest

发送PATCH网络请求
 **demo**
 ``` js
 network.patchRequest({
    url: 'https://api.mocki.io/v1/b043df5a',
    method: 'patch',
 }).then((res) => {
   console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | patch | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |


## downloadRequest

 interface DownloadReponseDTO {
     //返回的数据
     data: string
     //返回的状态
     status: int;
     //返回的头信息
     headers: Map<string, string>;
     //返回的请求参数
     request?: RequestDTO;
 }
发送下载请求
 **demo**
 ``` js
 network.downloadRequest({
    url: 'http://lihong.utools.club/api/excel/downLoadExcel?tableId=0104',
    method: 'download',
 }).then((res) => {
   console.log(res)
 }); 
 ``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求url |
| method | string | true | POST | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求haeders |
| params | Map\<string,string\> | true |  | 请求params |
| \_\_event\_\_ | string | true |  | progress: (progress:float)=>void |
| isNeedBase64 | bool |  |  | 是否需要base64的内容 |


## uploadRequest

发送上传请求
 **demo**
 ``` js
 network.uploadRequest({
    url: 'http://letonglexue.com/api/util/upload',
    method: 'upload',
    filename: 'custom.png',
    filepath: '',
 }).then((res) => {
    console.log(res)
 });
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string |  |  | 请求地址 |
| method | string | true | POST | 请求方法 |
| headers | Map\<string,string\> | true |  | 请求头 |
| params | Map\<string,string\> | true |  | 请求参数 |
| filename | string |  |  | 上传文件名称 |
| filepath | string | true |  | 上传文件路径 |
| fileBaseStr | string | true |  | 上传文件的base64 |
| \_\_event\_\_ | string | true |  | progress: (progress:float)=>void |

    

# iOS


# android



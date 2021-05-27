

JSI Id: com.zkty.module.network

version: 0.1.13



## getRequest

 ``` js<br> interface UploadReponseDTO {<br>     //返回状态<br>     status: int;<br>     //返回头<br>     headers: Map<string, string>;<br>     //返回请求体<br>     request?: UploadRequestDTO;<br>     //返回结果<br>     data: string<br> }<br> ```<br>发送GET网络请求<br>**demo**<br>``` js<br>network.getRequest({<br>   url: 'https://api.mocki.io/v1/b043df5a',<br>   method: 'get',<br>}).then((res) => {<br>  console.log(res)<br>});<br> ```

**demo**
``` js

    window.getRequest = () => {
        network.getRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'get',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## postRequest

发送POST网络请求 <br> **demo**<br> ``` js<br> network.postRequest({<br>    url: 'http://lihong.utools.club/api/user/login',<br>    method: 'post',<br>    params: {<br>      username: 'admin',<br>      passwork: 'e10adc3949ba59abbe56e057f20f883e'<br>    }<br> }).then((res) => {<br>   console.log(res)<br> });<br> ```

**demo**
``` js

    window.postRequest = () => {
        network.postRequest({
            url: 'http://lihong.utools.club/api/user/login',
            method: 'post',
            params: {
                username: 'admin',
                passwork: 'e10adc3949ba59abbe56e057f20f883e'
            }
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## deleteRequest

发送DELETE网络请求 <br> **demo**<br> ``` js<br> network.deleteRequest({<br>    url: 'https://api.mocki.io/v1/b043df5a',<br>    method: 'delete',<br> }).then((res) => {<br>   console.log(res)<br> });<br> ```

**demo**
``` js

    window.deleteRequest = () => {
        network.deleteRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'delete',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## headRequest

发送HEAD网络请求 <br> **demo**<br> ``` js<br> network.headRequest({<br>    url: 'https://api.mocki.io/v1/b043df5a',<br>    method: 'head',<br> }).then((res) => {<br>   console.log(res)<br> });<br> ```

**demo**
``` js

    window.headRequest = () => {
        network.headRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'head',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## putRequest

发送PUT网络请求 <br> **demo**<br> ``` js<br> network.putRequest({<br>    url: 'https://api.mocki.io/v1/b043df5a',<br>    method: 'put',<br> }).then((res) => {<br>   console.log(res)<br> });<br> ```

**demo**
``` js

    window.putRequest = () => {
        network.putRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'put',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## patchRequest

发送PATCH网络请求<br> **demo**<br> ``` js<br> network.patchRequest({<br>    url: 'https://api.mocki.io/v1/b043df5a',<br>    method: 'patch',<br> }).then((res) => {<br>   console.log(res)<br> });<br> ```

**demo**
``` js

    window.patchRequest = () => {
        network.patchRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'patch',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | patch | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |


---------------------
**返回值**
``` js


interface ReponseDTO {

    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: RequestDTO;

}
``` 




## downloadRequest

 interface DownloadReponseDTO {<br>     //返回的数据<br>     data: string<br>     //返回的状态<br>     status: int;<br>     //返回的头信息<br>     headers: Map<string, string>;<br>     //返回的请求参数<br>     request?: RequestDTO;<br> }<br>发送下载请求<br> **demo**<br> ``` js<br> network.downloadRequest({<br>    url: 'http://lihong.utools.club/api/excel/downLoadExcel?tableId=0104',<br>    method: 'download',<br> }).then((res) => {<br>   console.log(res)<br> }); <br> ``` 

**demo**
``` js

    window.downloadRequest = () => {
        network.downloadRequest({
            url: 'http://httpbin.org/image/jpeg',
            method: 'GET',
            __event__: (progress)=>{
                document.getElementById("debug_text").innerText = "下载进度" + progress + "%";
            },
        }).then((res) => {
            document.getElementById("debug_text").innerText = "下载成功";
            network.uploadRequest({
                url: 'http://httpbin.org/post',
                method: 'POST',
                filename: 'custom.png',
                filepath: res.filePath,
                __event__: (progress)=>{
                    document.getElementById("debug_text").innerText = "上传进度" + progress + "%";
                },
            }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
            });
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求url |
| method | string | optional | POST | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求haeders |
| params | Map\<string,string\> | optional |  | 请求params |
| \_\_event\_\_ | string | optional |  | progress: (progress:float)=>void |
| isNeedBase64 | bool | 必填 |  | 是否需要base64的内容 |


---------------------
**返回值**
``` js


interface DownloadReponseDTO {

    //下载文件的本地路径
    filePath: string
    //返回的数据base64
    base64DataStr?: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: DownloadRequestDTO;

}
``` 




## uploadRequest

发送上传请求<br> **demo**<br> ``` js<br> network.uploadRequest({<br>    url: 'http://letonglexue.com/api/util/upload',<br>    method: 'upload',<br>    filename: 'custom.png',<br>    filepath: '',<br> }).then((res) => {<br>    console.log(res)<br> });<br> ```

**demo**
``` js

    window.uploadRequest = () => {
        network.uploadRequest({
            url: 'http://httpbin.org/post',
            method: 'POST',
            filename: 'custom.png',
            filepath: '',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求地址 |
| method | string | optional | POST | 请求方法 |
| headers | Map\<string,string\> | optional |  | 请求头 |
| params | Map\<string,string\> | optional |  | 请求参数 |
| filename | string | 必填 |  | 上传文件名称 |
| filepath | string | optional |  | 上传文件路径 |
| fileBaseStr | string | optional |  | 上传文件的base64 |
| \_\_event\_\_ | string | optional |  | progress: (progress:float)=>void |


---------------------
**返回值**
``` js


interface UploadReponseDTO {

    //返回的数据
    data: string;
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string,
 string>;
    //返回的请求参数
    request?: UploadRequestDTO;

}
``` 



    
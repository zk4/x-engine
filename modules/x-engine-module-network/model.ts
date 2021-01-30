const moduleID = "com.zkty.module.network";

interface RequestDTO {
    //请求url
    url: string;
    //请求方法
    method?: string;
    //请求haeders
    headers?: Map<string, string>;
    //请求params
    params?: Map<string, string>;
}

interface ReponseDTO {
    //返回的数据
    data: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string, string>;
    //返回的请求参数
    request?: RequestDTO;
}

// download
interface DownloadRequestDTO {
    //请求url
    url: string;
    //请求方法
    method?: string;
    //请求haeders
    headers?: Map<string, string>;
    //请求params
    params?: Map<string, string>;
    //progress: (progress:float)=>void
    __event__?: string;
    //是否需要base64的内容
    isNeedBase64: boolean;
}

interface DownloadReponseDTO {
    //下载文件的本地路径
    filePath: string
    //返回的数据base64
    base64DataStr?: string
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string, string>;
    //返回的请求参数
    request?: DownloadRequestDTO;
}

interface UploadRequestDTO {
    //请求地址
    url: string;
    //请求方法
    method?: string;
    //请求头
    headers?: Map<string, string>;
    //请求参数
    params?: Map<string, string>;
    //上传文件名称
    filename: string;
    //上传文件路径
    filepath?: string;
    //上传文件的base64
    fileBaseStr?: string;

    //progress: (progress:float)=>void
    __event__?: string;
}

interface UploadReponseDTO {
    //返回的数据
    data: string;
    //返回的状态
    status: int;
    //返回的头信息
    headers: Map<string, string>;
    //返回的请求参数
    request?: UploadRequestDTO;
}
// ``` js
// interface UploadReponseDTO {
//     //返回状态
//     status: int;
//     //返回头
//     headers: Map<string, string>;
//     //返回请求体
//     request?: UploadRequestDTO;
//     //返回结果
//     data: string
// }
// ```
//发送GET网络请求
//**demo**
//``` js
//network.getRequest({
//   url: 'https://api.mocki.io/v1/b043df5a',
//   method: 'get',
//}).then((res) => {
//  console.log(res)
//});
// ```
function getRequest(config: RequestDTO = {
    url: '',
    method: 'get',
}): ReponseDTO {
    window.getRequest = () => {
        network.getRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'get',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };
}

//发送POST网络请求 
// **demo**
// ``` js
// network.postRequest({
//    url: 'http://lihong.utools.club/api/user/login',
//    method: 'post',
//    params: {
//      username: 'admin',
//      passwork: 'e10adc3949ba59abbe56e057f20f883e'
//    }
// }).then((res) => {
//   console.log(res)
// });
// ```
function postRequest(config: RequestDTO = {
    url: '',
    method: 'post',
}): ReponseDTO {
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
}

//发送DELETE网络请求 
// **demo**
// ``` js
// network.deleteRequest({
//    url: 'https://api.mocki.io/v1/b043df5a',
//    method: 'delete',
// }).then((res) => {
//   console.log(res)
// });
// ```
function deleteRequest(config: RequestDTO = {
    url: '',
    method: 'delete',
}): ReponseDTO {
    window.deleteRequest = () => {
        network.deleteRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'delete',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };
}

//发送HEAD网络请求 
// **demo**
// ``` js
// network.headRequest({
//    url: 'https://api.mocki.io/v1/b043df5a',
//    method: 'head',
// }).then((res) => {
//   console.log(res)
// });
// ```
function headRequest(config: RequestDTO = {
    url: '',
    method: 'head',
}): ReponseDTO {
    window.headRequest = () => {
        network.headRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'head',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };
}

//发送PUT网络请求 
// **demo**
// ``` js
// network.putRequest({
//    url: 'https://api.mocki.io/v1/b043df5a',
//    method: 'put',
// }).then((res) => {
//   console.log(res)
// });
// ```
function putRequest(config: RequestDTO = {
    url: '',
    method: 'put',
}): ReponseDTO {
    window.putRequest = () => {
        network.putRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'put',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };
}

//发送PATCH网络请求
// **demo**
// ``` js
// network.patchRequest({
//    url: 'https://api.mocki.io/v1/b043df5a',
//    method: 'patch',
// }).then((res) => {
//   console.log(res)
// });
// ```
function patchRequest(config: RequestDTO = {
    url: '',
    method: 'patch',
}): ReponseDTO {
    window.patchRequest = () => {
        network.patchRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'patch',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };
}


// interface DownloadReponseDTO {

//     //返回的数据
//     data: string
//     //返回的状态
//     status: int;
//     //返回的头信息
//     headers: Map<string, string>;
//     //返回的请求参数
//     request?: RequestDTO;
// }

//发送下载请求
// **demo**
// ``` js
// network.downloadRequest({
//    url: 'http://lihong.utools.club/api/excel/downLoadExcel?tableId=0104',
//    method: 'download',
// }).then((res) => {
//   console.log(res)
// }); 
// ``` 
function downloadRequest(config: DownloadRequestDTO = { url: '', method: 'POST', isNeedBase64: false }): DownloadReponseDTO {
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
}

//发送上传请求
// **demo**
// ``` js
// network.uploadRequest({
//    url: 'http://letonglexue.com/api/util/upload',
//    method: 'upload',
//    filename: 'custom.png',
//    filepath: '',
// }).then((res) => {
//    console.log(res)
// });
// ```
function uploadRequest(config: UploadRequestDTO = { url: '', method: 'POST' }): UploadReponseDTO {
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
}

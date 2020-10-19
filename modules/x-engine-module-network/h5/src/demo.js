
import network from './index.js'

    window.getRequest = () => {
        network.getRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'get',
        }).then((res) => {
            document.getElementById("debug_text").innerText = JSON.stringify(res);
        });
    };

    window.postRequest = () => {
        network.postRequest({
            url: 'http://lihong.utools.club/api/user/login',
            method: 'post',
            params: {
                username: 'admin',
                passwork: 'e10adc3949ba59abbe56e057f20f883e'
            }
        }).then((res) => {
            document.getElementById("debug_text").innerText = res;
        });
    };

    window.deleteRequest = () => {
        network.deleteRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'delete',
        }).then((res) => {
            document.getElementById("debug_text").innerText = res;
        });
    };

    window.headRequest = () => {
        network.headRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'head',
        }).then((res) => {
            document.getElementById("debug_text").innerText = res;
        });
    };

    window.putRequest = () => {
        network.putRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'put',
        }).then((res) => {
            document.getElementById("debug_text").innerText = res;
        });
    };

    window.patchRequest = () => {
        network.patchRequest({
            url: 'https://api.mocki.io/v1/b043df5a',
            method: 'patch',
        }).then((res) => {
            document.getElementById("debug_text").innerText = res;
        });
    };

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
                document.getElementById("debug_text").innerText = JSON.stringify(res.data);
            });
        });
    };

    window.uploadRequest = () => {
        network.uploadRequest({
            url: 'http://httpbin.org/post',
            method: 'POST',
            filename: 'custom.png',
            filepath: '',
        }).then((res) => {
            document.getElementById("debug_text").innerText = res.data;
        });
    };

    
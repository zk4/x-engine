import axios from 'axios'
// import NProgress from "nprogress"
// import JSONbig from 'json-bigint'
// import message from 'ant-design-vue/es/message'
// import * as api from "@/api/login";
// import QS from "qs";


let BASEURL = ''
if (process.env.NODE_ENV === 'development') {
  BASEURL = '/'
  // BASEURL = "http://sit.linli580.com:8888/";
} else {
  BASEURL = "http://dev.linli590.cn:16666/";
  // BASEURL = "http://dev.linli580.com:16666/";
  // BASEURL = "http://10.71.31.41:7000/";
  // BASEURL = "http://172.20.10.4:3000/";
  // BASEURL = location.origin
}

// const JSONBigString = JSONbig({"storeAsString": true});
export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: false,
  // withCredentials: true,
  timeout: 20000,
  headers: {
    // post: {
    //   'Content-Type': 'application/json'
    // }
  },
  // transformResponse: [
  //   function (data) {
  //     // return JSONBigString.parse(data)
  //   }
  // ]
});

//请求拦截
HTTP.interceptors.request.use(async (config) => {
  // NProgress.start()
  
  

  if (process.env.NODE_ENV === 'development') {
    let tokenStr = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJmYW5qaXVqaXUiLCJzY29wZSI6WyJhbGwiXSwiaWQiOjEsImV4cCI6MTYwNDIzNzA1NSwiYXV0aG9yaXRpZXMiOlsiYXBwX2FjdGl2aXR5X2FkbWluIiwiYXBwX3F1YWxpdHlfYWRtaW4iLCJhcHBfaG91c2VfYWRtaW4iLCJhcHBfdmlzaXRvcl9hZG1pbiIsInN5c19hZG1pbiIsImFwcF9hZHZlcnRfYWRtaW4iLCJhcHBfbm90aWNlX2FkbWluIiwiYXBwX2FyZWFfYWRtaW4iLCJhcHBfZGVjb3JhdGVfYWRtaW4iLCJhcHBfdmVoaWNsZV9hZG1pbiIsImFwcF9hcmVhX2VtcF9hZG1pbiIsImFwcF9wYXNzYWdlX2FkbWluIiwiYW55dGltZXMiLCJhcHBfdXNlcl9hZG1pbiIsImFwcF9zcGFjZV9hZG1pbiIsImFwcF9vd25lcl9hZG1pbiIsImFwcF9jb21wYW55X2xpYl9hZG1pbiJdLCJqdGkiOiIxMjc5NDUyYi1kZjYwLTQ2MzAtYWIxMC1iMzFiZWIwYWYyOTUiLCJjbGllbnRfaWQiOiIyMDM4NTc4MzEifQ.gdkJyylzkex0CVLwH8tYAu1k6JWv8aLkK80MjctVMckDLMpqGYOEB5gJ4gVsGRJ7uBIiKvpJKo8PWdCk3OZ4DfDdcVoV4xwo5r0blvYgAmra9GoYFIt7NJ4vIAzvoTVd6AGb74M7o7WbKYEQ84KP3e4k3HftNUsd7Ihuo7_EyLiN8rYLCRe7DOaYg8JswGXHRfYxo83aAlBjC5lwwfsrSFWsSbO32TT22cFeCSzD6Wr2CbcSfJ6jQuxRHpENBv2Molz3lf1G3sLblMZHWVG9r0KRcm8bdrspUb2mdLAUF52fe7JnKZ3qEyr9C6sp5hq2B0WwksfD0m-K5SkMAoZ3sQ`
    config.headers.Authorization = tokenStr;
    return config
  } else {
    // let tokenStr = "Bearer " + localStorage.getItem("SD_ACCESS_TOKEN");
    // config.headers.Authorization = tokenStr;
    // return config
    let tokenStr = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJmYW5qaXVqaXUiLCJzY29wZSI6WyJhbGwiXSwiaWQiOjEsImV4cCI6MTYwNDIzNzA1NSwiYXV0aG9yaXRpZXMiOlsiYXBwX2FjdGl2aXR5X2FkbWluIiwiYXBwX3F1YWxpdHlfYWRtaW4iLCJhcHBfaG91c2VfYWRtaW4iLCJhcHBfdmlzaXRvcl9hZG1pbiIsInN5c19hZG1pbiIsImFwcF9hZHZlcnRfYWRtaW4iLCJhcHBfbm90aWNlX2FkbWluIiwiYXBwX2FyZWFfYWRtaW4iLCJhcHBfZGVjb3JhdGVfYWRtaW4iLCJhcHBfdmVoaWNsZV9hZG1pbiIsImFwcF9hcmVhX2VtcF9hZG1pbiIsImFwcF9wYXNzYWdlX2FkbWluIiwiYW55dGltZXMiLCJhcHBfdXNlcl9hZG1pbiIsImFwcF9zcGFjZV9hZG1pbiIsImFwcF9vd25lcl9hZG1pbiIsImFwcF9jb21wYW55X2xpYl9hZG1pbiJdLCJqdGkiOiIxMjc5NDUyYi1kZjYwLTQ2MzAtYWIxMC1iMzFiZWIwYWYyOTUiLCJjbGllbnRfaWQiOiIyMDM4NTc4MzEifQ.gdkJyylzkex0CVLwH8tYAu1k6JWv8aLkK80MjctVMckDLMpqGYOEB5gJ4gVsGRJ7uBIiKvpJKo8PWdCk3OZ4DfDdcVoV4xwo5r0blvYgAmra9GoYFIt7NJ4vIAzvoTVd6AGb74M7o7WbKYEQ84KP3e4k3HftNUsd7Ihuo7_EyLiN8rYLCRe7DOaYg8JswGXHRfYxo83aAlBjC5lwwfsrSFWsSbO32TT22cFeCSzD6Wr2CbcSfJ6jQuxRHpENBv2Molz3lf1G3sLblMZHWVG9r0KRcm8bdrspUb2mdLAUF52fe7JnKZ3qEyr9C6sp5hq2B0WwksfD0m-K5SkMAoZ3sQ`
    config.headers.Authorization = tokenStr;
    return config
  }

  

});


function handleParams(url, rawData, rawMethod) {
  const method = rawMethod.toUpperCase()
  let data = {}
  if (method === 'GET') {
    data = {params: rawData}
  }
  switch (method) {
    case 'GET':
      data = {params: rawData}
      break
    case 'POST':
    case 'PUT':
    case 'PATCH':
    case 'DELETE':
      data = {data: rawData}
      break
    default:
      data = {params: rawData}
      break
  }

  return Promise.resolve({
    url,
    method,
    data
  })
}

async function handleFail(option) {
  console.log(option)
  const {error, reject} = option
  const {response} = error
  if (response) {
    switch (response.status) {
      case 400:
        // message.error('请求失败')
        break
      case 401:
        break
      case 403:
        break
      case 404:
        // message.error('请求失败')
        break
      case 500:
        // message.error('请求失败')
        break
      default:
        break
    }
  } else {
    // var originalRequest = error.config;
    // if(error.code == 'ECONNABORTED' && error.message.indexOf('timeout')!=-1 && !originalRequest._retry){
    //     originalRequest._retry = true
    //     message.error('请求超时')
    // }
  }
  reject(error)
}

let defaultHeader = {
  timezoneoffset: Math.abs(new Date().getTimezoneOffset() / 60),
  locale: 'zh_CN',
  get: {
    'Content-Type': 'application/x-www-form-urlencoded'
  }
}

// let refresh = false;
// async function refreshToken() {
//   refresh = true;
//   const para = QS.stringify({
//     grant_type: "refresh_token",
//     client_id: "203857830",
//     client_secret: "sonN7DzqEBiRS8TZlCyJ9KWHd35ZSA5g",
//     username: window.localStorage.getItem("SD_LOGIN_NAME"),
//     password: "",
//     scope: "all",
//     refresh_token: window.localStorage.getItem("SD_ACCESS_REFRESHTOKEN")
//   })
//   api.toLogin(para).then(res => {
//     if (res.code === 200) {
//       window.localStorage.setItem("SD_ACCESS_TOKEN", res.data.token);
//       window.localStorage.setItem("SD_ACCESS_REFRESHTOKEN", res.data.refreshToken);
//       location.reload();
//     }
//   }).finally(() => {
//   });
// }

export const fetchApi = (api, rawData = {}, method = 'GET', headers = {}, url = BASEURL) => {
  return handleParams(api, rawData, method, headers).then(options => {
    return new Promise((resolve, reject) => {
      HTTP({
        baseURL: url,
        // withCredentials: true,
        withCredentials: false,
        url: options.url,
        method: options.method,
        headers: {...defaultHeader, ...headers},
        ...options.data
      })
      .then(resp => {
        // NProgress.done()
        const res = resp.data
        if (res.code === 0) {
          resolve(res)
        } else {
          if (res.code === 401) {
            resolve(res)
          } else if (res.code !== 200) {
            resolve(res)
            // message.error(res.message)
          } else {
            resolve(res)
          }
        }
      }, error => {
        // NProgress.done()
        handleFail({
          error,
          reject,
          options
        })

        throw error
      })
    })
  })
}

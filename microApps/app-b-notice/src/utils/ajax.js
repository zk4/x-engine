import axios from 'axios'
// import NProgress from "nprogress"
import JSONbig from 'json-bigint'
// import message from 'ant-design-vue/es/message'
// import * as api from "@/api/login";
// import QS from "qs";


let BASEURL = ''
if (process.env.NODE_ENV === 'development') {
  BASEURL = '/'
  // BASEURL = "http://sit.linli580.com:8888/";
} else {
  BASEURL = "http://dev.linli580.com:16666/";
  // BASEURL = "http://sit.linli580.com:8888/";
  // BASEURL = location.origin
}

const JSONBigString = JSONbig({"storeAsString": true});
export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: true,
  timeout: 20000,
  headers: {
    // post: {
    //   'Content-Type': 'application/json'
    // }
  },
  transformResponse: [
    function (data) {
      return JSONBigString.parse(data)
    }
  ]
});

//请求拦截
HTTP.interceptors.request.use(async (config) => {
  // NProgress.start()



  if (process.env.NODE_ENV === 'development') {
    let tokenStr = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJub3RpY2UiLCJzY29wZSI6WyJhbGwiXSwiaWQiOjIxNjUxNjI2NjExMDMyNzE5NTIsImV4cCI6MTYwNDAyMTI2NCwiYXV0aG9yaXRpZXMiOlsiYXBwX25vdGljZV9hZG1pbiIsImFueXRpbWVzIl0sImp0aSI6IjkyNGY3YzgyLTk5ODYtNDNhYS1iN2Q4LWUyZmZlOTJlY2I0ZCIsImNsaWVudF9pZCI6IjIwMzg1NzgyOCJ9.jCOQXbChDtIGsqxcxo2U1yywDMX6grec00hk6FlEdVesT68hQa-CrW7m-SuKk6B61TtyUHn_c4WzK9nO4OYk5BymY1bovHaD-5UswVv9x-pzI2lQpZEUD5-cZhzL3YQX4kwvgsHJtX1U2fkj07udalCUbEO6anRxNuEFxs5XCh4RxDNbhEwyPD-Jf0oOmPEuLxIUBUs1FWleG_Csb3V8-M03DACa3Fb_7ui07yv1h5C6HABrHkZ6y71G6NrdUiYZhBrZGM3Hhti7DT7X-drQvWNHASjKKTkvibSB6gUkWpzv4sB0L-LoEPTjgXQwmZehT8uEn9WO5v13u5XeUfQMMQ`
    config.headers.Authorization = tokenStr;
    return config
  } else {
    // let tokenStr = "Bearer " + localStorage.getItem("SD_ACCESS_TOKEN");
    // config.headers.Authorization = tokenStr;
    // return config
    let tokenStr = `eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJub3RpY2UiLCJzY29wZSI6WyJhbGwiXSwiaWQiOjIxNjUxNjI2NjExMDMyNzE5NTIsImV4cCI6MTYwNDAyMTI2NCwiYXV0aG9yaXRpZXMiOlsiYXBwX25vdGljZV9hZG1pbiIsImFueXRpbWVzIl0sImp0aSI6IjkyNGY3YzgyLTk5ODYtNDNhYS1iN2Q4LWUyZmZlOTJlY2I0ZCIsImNsaWVudF9pZCI6IjIwMzg1NzgyOCJ9.jCOQXbChDtIGsqxcxo2U1yywDMX6grec00hk6FlEdVesT68hQa-CrW7m-SuKk6B61TtyUHn_c4WzK9nO4OYk5BymY1bovHaD-5UswVv9x-pzI2lQpZEUD5-cZhzL3YQX4kwvgsHJtX1U2fkj07udalCUbEO6anRxNuEFxs5XCh4RxDNbhEwyPD-Jf0oOmPEuLxIUBUs1FWleG_Csb3V8-M03DACa3Fb_7ui07yv1h5C6HABrHkZ6y71G6NrdUiYZhBrZGM3Hhti7DT7X-drQvWNHASjKKTkvibSB6gUkWpzv4sB0L-LoEPTjgXQwmZehT8uEn9WO5v13u5XeUfQMMQ`
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
        withCredentials: true,
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

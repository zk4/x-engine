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
  BASEURL = "http://172.20.10.4:3000/";
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
    let tokenStr = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJmY2RhIiwic2NvcGUiOlsiYWxsIl0sImlkIjoyMjIxNDgzMjM3MjcwNjE4Mjk3LCJleHAiOjE2MDM4MDYwNDQsImF1dGhvcml0aWVzIjpbImFwcF9ob3VzZV9hZG1pbiIsImFueXRpbWVzIl0sImp0aSI6Ijk0ZTI1MDliLWEzYjktNGE3Mi05ZDg3LTI5M2ZlZWRiNmUwYyIsImNsaWVudF9pZCI6IjIwMzg1NzgzMSJ9.MEeE2V9Ult3xVfeSQkwStdoOzq-v2p5qxf2yAh9xFrLUmZBgb0qFjB-3czrC5pKNQCwPWZ2iVAt3K78CU5GCnKPW4PLc959V7PN9Xe0-CDNrlc8VFf9gmFjW6myYXERXwUQqMF2VbGB6sDXGa-_lVtT9FptdMlaB6xB8jZpaZs1SCqdiaPb3y-Dn9QPvQZ-tE4EJHol8HU-T5YUxJiB94i8R-qp8c5BaDQ1Jg7KotJ-jQNpx6GalvbwGXMiyeIfQUYvjqUUQaqwPSM5Hno8bPYSmO6fCmMZK3fwHubbjAzZpMu08Y90Ny5wt_yd1_bqxbctwXXXP-y-aWXLSPhbMKg`
    config.headers.Authorization = tokenStr;
    return config
  } else {
    // let tokenStr = "Bearer " + localStorage.getItem("SD_ACCESS_TOKEN");
    // config.headers.Authorization = tokenStr;
    // return config
    let tokenStr = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJmY2RhIiwic2NvcGUiOlsiYWxsIl0sImlkIjoyMjIxNDgzMjM3MjcwNjE4Mjk3LCJleHAiOjE2MDM4MDYwNDQsImF1dGhvcml0aWVzIjpbImFwcF9ob3VzZV9hZG1pbiIsImFueXRpbWVzIl0sImp0aSI6Ijk0ZTI1MDliLWEzYjktNGE3Mi05ZDg3LTI5M2ZlZWRiNmUwYyIsImNsaWVudF9pZCI6IjIwMzg1NzgzMSJ9.MEeE2V9Ult3xVfeSQkwStdoOzq-v2p5qxf2yAh9xFrLUmZBgb0qFjB-3czrC5pKNQCwPWZ2iVAt3K78CU5GCnKPW4PLc959V7PN9Xe0-CDNrlc8VFf9gmFjW6myYXERXwUQqMF2VbGB6sDXGa-_lVtT9FptdMlaB6xB8jZpaZs1SCqdiaPb3y-Dn9QPvQZ-tE4EJHol8HU-T5YUxJiB94i8R-qp8c5BaDQ1Jg7KotJ-jQNpx6GalvbwGXMiyeIfQUYvjqUUQaqwPSM5Hno8bPYSmO6fCmMZK3fwHubbjAzZpMu08Y90Ny5wt_yd1_bqxbctwXXXP-y-aWXLSPhbMKg`
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

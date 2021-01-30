import axios from 'axios'
// import NProgress from "nprogress"
// import JSONbig from 'json-bigint'
// import message from 'ant-design-vue/es/message'
import api from "@/api";
import QS from "qs";
import localstorage from "@zkty-team/x-engine-module-localstorage";
// import { Toast } from 'vant';

let BASEURL = ''
let RERRESH = ''
if (process.env.NODE_ENV === 'development') {
  BASEURL = '/'
  // BASEURL = "http://dev.linli580.com:10000/";
} else {
  // BASEURL = location.origin
  BASEURL = "http://dev.linli590.cn:16666/";
}

// const JSONBigString = JSONbig({"storeAsString": true});
export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: false,
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
  
  
  let tokenStr1;
  if (process.env.NODE_ENV === 'development') {
    await localstorage.get({key: "LLBToken",isPublic: true}).then((res) => {
      tokenStr1 = "Bearer " + res.result;
      // tokenStr1 = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxMzcyOTA3ODgzNyIsInNjb3BlIjpbImFsbCJdLCJpZCI6MjIyNzcyNjYwNzg5MDUxNDAwMywiZXhwIjoxNjA0MjM2NzA5LCJhdXRob3JpdGllcyI6WyJ2aXNpdG9yIl0sImp0aSI6Ijc2YTAxYTFlLWEwMjMtNGYxNy05NzFjLWEyNzg2MTM2N2Y2NSIsImNsaWVudF9pZCI6IjIwMzg1NzgyOSJ9.bebr1dI5R5i5uIg5VZlY4KbGnWnRR8bkSX9bWYkQbPjNVETIKM3ANvsQ2durUIa8T5cgvx9YA57TMVFRGgqOc2QKf1y1UUnmK--2U_B7BpRmC6MwKW_psHvMYnXXnGHWO1gAFpgxctKg4pa-H2Org2RR8rQCkZF-e22AfQ4QfsKOno2fujYGiLGfeq5AFH6ZXZ_U6bZDWvQ_b6Oo8bPkCVHf5zOJx0mFtqsR3yp7vX8rrVfxBy4ZReUxPapikN_z3IYfOu722CtdpoGIhs72Rx7Z3f2wNLT4pexUfrk1p48nQdGSe763gIEUZAekNwnz1ALOwu4gR_v3JP0z6aze5g`
    });
    await localstorage.get({key: "LLBRefreshToken",isPublic: true}).then((res) => {
      RERRESH = "Bearer " + res.result;
      // tokenStr1 = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxMzcyOTA3ODgzNyIsInNjb3BlIjpbImFsbCJdLCJpZCI6MjIyNzcyNjYwNzg5MDUxNDAwMywiZXhwIjoxNjA0MjM2NzA5LCJhdXRob3JpdGllcyI6WyJ2aXNpdG9yIl0sImp0aSI6Ijc2YTAxYTFlLWEwMjMtNGYxNy05NzFjLWEyNzg2MTM2N2Y2NSIsImNsaWVudF9pZCI6IjIwMzg1NzgyOSJ9.bebr1dI5R5i5uIg5VZlY4KbGnWnRR8bkSX9bWYkQbPjNVETIKM3ANvsQ2durUIa8T5cgvx9YA57TMVFRGgqOc2QKf1y1UUnmK--2U_B7BpRmC6MwKW_psHvMYnXXnGHWO1gAFpgxctKg4pa-H2Org2RR8rQCkZF-e22AfQ4QfsKOno2fujYGiLGfeq5AFH6ZXZ_U6bZDWvQ_b6Oo8bPkCVHf5zOJx0mFtqsR3yp7vX8rrVfxBy4ZReUxPapikN_z3IYfOu722CtdpoGIhs72Rx7Z3f2wNLT4pexUfrk1p48nQdGSe763gIEUZAekNwnz1ALOwu4gR_v3JP0z6aze5g`
    });
    // Toast(RERRESH)
    config.headers.Authorization = tokenStr1;
    return config
  } else {
    await localstorage.get({key: "LLBToken",isPublic: true}).then((res) => {
      tokenStr1 = "Bearer " + res.result;
      // tokenStr1 = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxMzcyOTA3ODgzNyIsInNjb3BlIjpbImFsbCJdLCJpZCI6MjIyNzcyNjYwNzg5MDUxNDAwMywiZXhwIjoxNjA0MjM2NzA5LCJhdXRob3JpdGllcyI6WyJ2aXNpdG9yIl0sImp0aSI6Ijc2YTAxYTFlLWEwMjMtNGYxNy05NzFjLWEyNzg2MTM2N2Y2NSIsImNsaWVudF9pZCI6IjIwMzg1NzgyOSJ9.bebr1dI5R5i5uIg5VZlY4KbGnWnRR8bkSX9bWYkQbPjNVETIKM3ANvsQ2durUIa8T5cgvx9YA57TMVFRGgqOc2QKf1y1UUnmK--2U_B7BpRmC6MwKW_psHvMYnXXnGHWO1gAFpgxctKg4pa-H2Org2RR8rQCkZF-e22AfQ4QfsKOno2fujYGiLGfeq5AFH6ZXZ_U6bZDWvQ_b6Oo8bPkCVHf5zOJx0mFtqsR3yp7vX8rrVfxBy4ZReUxPapikN_z3IYfOu722CtdpoGIhs72Rx7Z3f2wNLT4pexUfrk1p48nQdGSe763gIEUZAekNwnz1ALOwu4gR_v3JP0z6aze5g`
    });
    await localstorage.get({key: "LLBRefreshToken",isPublic: true}).then((res) => {
      RERRESH = "Bearer " + res.result;
      // tokenStr1 = `Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIxMzcyOTA3ODgzNyIsInNjb3BlIjpbImFsbCJdLCJpZCI6MjIyNzcyNjYwNzg5MDUxNDAwMywiZXhwIjoxNjA0MjM2NzA5LCJhdXRob3JpdGllcyI6WyJ2aXNpdG9yIl0sImp0aSI6Ijc2YTAxYTFlLWEwMjMtNGYxNy05NzFjLWEyNzg2MTM2N2Y2NSIsImNsaWVudF9pZCI6IjIwMzg1NzgyOSJ9.bebr1dI5R5i5uIg5VZlY4KbGnWnRR8bkSX9bWYkQbPjNVETIKM3ANvsQ2durUIa8T5cgvx9YA57TMVFRGgqOc2QKf1y1UUnmK--2U_B7BpRmC6MwKW_psHvMYnXXnGHWO1gAFpgxctKg4pa-H2Org2RR8rQCkZF-e22AfQ4QfsKOno2fujYGiLGfeq5AFH6ZXZ_U6bZDWvQ_b6Oo8bPkCVHf5zOJx0mFtqsR3yp7vX8rrVfxBy4ZReUxPapikN_z3IYfOu722CtdpoGIhs72Rx7Z3f2wNLT4pexUfrk1p48nQdGSe763gIEUZAekNwnz1ALOwu4gR_v3JP0z6aze5g`
    });
    // Toast(RERRESH)
    config.headers.Authorization = tokenStr1;
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


let refresh = false;
async function refreshToken() {
  refresh = true;
  const para = QS.stringify({
    grant_type: "refresh_token",
    client_id: "203857829",
    client_secret: "0nGmajrHsJhK3WkPFeNuoJcZZZ5USa1f",
    scope: "all",
    refresh_token: RERRESH
  })
  api.toLogin(para).then(res => {
    if (res.code === 200) {
      localstorage.set({
        key: "token",
        value: res.dta.token,
        isPublic: false,
      })
      location.reload();
    }
  }).finally(() => {
  });
}

export const fetchApi = (api, rawData = {}, method = 'GET', headers = {}, url = BASEURL) => {
  return handleParams(api, rawData, method, headers).then(options => {
    return new Promise((resolve, reject) => {
      HTTP({
        baseURL: url,
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
            if (refresh) {
              resolve(res)
            } else {
              resolve(res)
              refreshToken();
            }
          } else if (res.code !== 200) {
            resolve(res)
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

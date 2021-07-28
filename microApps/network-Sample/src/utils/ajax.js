import axios from 'axios'

// 创建axios实例
const service = axios.create({
    baseURL: 'https://www.fastmock.site',
    timeout: 50000 // 请求超时时间
})

// request拦截器
service.interceptors.request.use(
    config => {
        config.headers['Authorization'] = 'Basic '
        return config
    },
    error => {
        // Do something with request error
        console.log(error) // for debug
        Promise.reject(error)
    }
)

// response 拦截器
service.interceptors.response.use(
    response => {
        /**
         * code为非20000是抛错 可结合自己业务进行修改
         */
        const res = response.data
        if (res.status !== 200) {
            return res
        } else {
            return res
        }
    },
    error => {
        console.log(error) // for debug
        return Promise.reject(error)
    }
)

service.get = function get(url, param) {
    try {
        return new Promise((resolve, reject) => {
            service({
                method: 'get',
                url,
                params: param
            }).then(res => {
                resolve(res)
            }).catch(err => {
                reject(err)
            })
        })
    } catch (err) {
        return Promise.reject(err)
    }
}

service.post = function post(url, param) {
    return new Promise((resolve, reject) => {
        service({
            method: 'post',
            url,
            data: param
        }).then(res => { 
            resolve(res)
        }).catch(err => { 
            reject(err)
        })
    })
}
export default service
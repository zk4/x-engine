import { fetchApi } from '@/utils/ajax'
import URL from './urlConfig'

//登录
// export function Login(data) {
//     return fetchApi(URL.LOGIN, data, 'POST')
// }

//登录箭头函数
export const toLogin = data => fetchApi(URL.LOGIN, data, "POST");
//退出登录
export const toLogout = data => fetchApi(URL.LOGOUT, data, 'POST');
//发送验证码
export const sendCode = data => fetchApi(URL.SEND_CODE, data, 'POST');

import { fetchApi } from '@/utils/ajax'
import URL from './urlConfig'


//房屋列表
export const houselist = data => fetchApi(URL.APP_B, data, "GET");
//房屋基本信息
export const houseroom = data => fetchApi(URL.APP_ROOM, data, "GET");
//房产档案查询用户授权的项目列表
export const houseject = data => fetchApi(URL.APP_JECT, data, "GET");
// 获取业主变更信息接口
export const housetoken = data => fetchApi(URL.APP_TOKEN, data, "GET");
// 删除住户信息（非业主）
export const housetomer = data => fetchApi(URL.APP_TOMER, data, "POST");
// 根据房间号获取住户列表
export const housecust = data => fetchApi(URL.APP_CUST, data, "GET");
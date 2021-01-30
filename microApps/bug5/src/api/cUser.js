import {fetchApi} from '@/utils/ajax'
import URL from './urlConfig'

export const getUserQuery = data => fetchApi(URL.USER_QUERY, data, "GET");
export const ownerCert = data => fetchApi(URL.OWNER_CERT, data, "POST");
export const getRealNameQuery = data => fetchApi(URL.REALNAME_QUERY, data, "GET");
export const cancelAccount = data => fetchApi(URL.CANCEL_ACCOUNT, data, "POST");

export const getCustomerList = data => fetchApi(URL.CUSTOMER_LIST, data, "GET");
export const getRoomList = data => fetchApi(URL.MY_ROMLIST, data, "GET");
export const changePhonenum = data => fetchApi(URL.CHANGE_PHONENUM, data, "POST");
export const delUser = data => fetchApi(URL.DEL_USER, data, "POST");
export const addOwner = data => fetchApi(URL.ADD_OWNER, data, "POST");

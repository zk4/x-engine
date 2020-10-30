import {fetchApi} from '@/utils/ajax'
import URL from './urlConfig'

export const getNotice = data => fetchApi(URL.NOTICE_LIST, data, "GET");
export const getNoticeDetail = data => fetchApi(URL.NOTICE_DETAIL, data, "GET");
export const getProjectList = data => fetchApi(URL.PROJECT_LIST, data, "GET");
export const getAllNoticeType = data => fetchApi(URL.NOTICETYPE_LIST, data, "GET");
export const addNotice = data => fetchApi(URL.ADD_NOTICE, data, "POST");
export const editNotice = data => fetchApi(URL.EDIT_NOTICE, data, "POST");
export const deleteNotice = data => fetchApi(URL.DELETE_NOTICE, data, "POST");
export const revocationNotice = data => fetchApi(URL.REVOCATION_NOTICE, data, "POST");

export const uploadPropertyNoticePic = data => fetchApi(URL.PROPERTY_NOTICE_PIC_UPLOAD, data , "POST");
export const updateNoticeDetail = data => fetchApi(URL.UPDATENOTICE, data, "POST");
export const upPara = data => fetchApi(URL.UPPARA, data, "POST");
export const getRedisNotice = data => fetchApi(URL.GET_REDISNOTICE, data, "GET");


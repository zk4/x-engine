import network from "@zkty-team/x-engine-module-network";
import {appConfig} from "../config";

const {baseDomain} = appConfig.domain;
const {userTokenKey} =appConfig.cookie;

const headers = {
    Authorization:userTokenKey
};

const createNoticeHeader = {
    Authorization:userTokenKey,
    contentType:'multipart/form-data'
}
const GET = 'GET'

const PUT = 'PUT'

const DELETE = 'DELETE'

const POST = 'POST'

/**
 * 获取项目名称列表
 */
export const getProjectMenus = () => {
    const url = baseDomain.concat('/notices/1')
    const new_params = {
        url,
        method:GET,
        headers,
    }
    console.log(`获取项目名称列表`,new_params)
    return network.request(new_params);
};
/**
 * 创建公告
 * @param {title publisher detail} params 
 */
export const createOrEditNotice = (param,id) => {
    const url = id ? baseDomain.concat(`/notice/${id}`) : baseDomain.concat('/notice');
    const new_params = {
        url,
        method:POST,
        createNoticeHeader,
        ...param
    }
    console.log(`创建公告`,new_params)
    return network.request(new_params);
}
/**
 * 根据项目名称查询公告列表
 */
export const getNoticesByProject = (params,status) => {
    const url = baseDomain.concat('/notices/1')
    const new_params = {
        url,
        method:GET,
        headers,
        status,
        ...params
    }
    console.log(`根据项目名称查询公告列表`,new_params)
    return network.request(new_params);
};
/**
 * 公告详情
 */
export const noticeDetail = (noticeId) =>{
    const url = baseDomain.concat(`/notice/${noticeId}`);
    const params = {
        url,
        method:GET,
        headers,
    }
    console.log(`公告详情`,params)
    return network.request(params);
}
// 删除公告
export const deleteNotice = (noticeId) =>{
    const url = baseDomain.concat(`/notice/${noticeId}`);
    const params = {
        url,
        method:DELETE,
        headers,
    }
    console.log(`删除公告`,params)
    return network.request(params);
}
// 撤回公告
export const revokeNotice = (noticeId) =>{
    const url = baseDomain.concat(`/notice/${noticeId}`);
    const params = {
        url,
        method:PUT,
        headers,
    }
    console.log(`撤回公告`,params)
    return network.request(params);
}
// 获取编辑得公告得信息
export const editNotice = (noticeId) =>{
    const url = baseDomain.concat(`/notice/${noticeId}`);
    const params = {
        url,
        method:GET,
        headers,
    }
    console.log(`编辑公告`,params)
    return network.request(params);
}

/**
 * 获取等级列表
 * 暂无
 */
export const levelList = () =>{
    const url = baseDomain.concat(`/notice/`);
    const params = {
        url,
        method:GET,
        headers,
    }
    console.log(`获取等级列表`,params)
    return network.request(params);
}
/**
 * 获取公告类型列表
 * 暂无
 */

export const typeList = () =>{
    const url = baseDomain.concat(`/notice/types`);
    const params = {
        url,
        method:GET,
        headers,
    }
    console.log(`获取类型列表`,params)
    return network.request(params);
}


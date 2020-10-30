export let option = {
  pub: '/times/pub-center', //PUB
  notice: '/times/notice-service/notice', // 物业公告
};

// 请求地址
export default {
  NOTICE_LIST: option.notice + '/api/v1/queryNoticeByProID', // 物业公告列表
  NOTICE_DETAIL: option.notice + '/api-c/v1/queryNoticeById', // 物业公告详情
  PROJECT_LIST: option.notice + '/api/v1/queryProjectsByUser', // 项目列表
  NOTICETYPE_LIST: option.notice + '/api/v1/queryAllNoticeType', // 类型列表
  ADD_NOTICE: option.notice + '/api/v1/addNotice', // 创建公告
  EDIT_NOTICE: option.notice + '/api/v1/updateNotice', // 编辑公告
  DELETE_NOTICE: option.notice + '/api/v1/delNotice', // 删除公告
  REVOCATION_NOTICE: option.notice + '/api/v1/updateRecallNotice', // 撤回公告
  PROPERTY_NOTICE_PIC_UPLOAD: option.notice + '/api/v1/upload', // 公告图片上传
  UPDATENOTICE: option.notice + '/api/v1/updateNotice', //更新物业公告
  UPPARA: option.notice + '/api/v1/addRedisNotice', //参数上传
  GET_REDISNOTICE: option.notice + '/api/v1/queryRedisNotice', //获取参数
}

export let option = {
  pub: '/times/pub-center', //PUB
  c_user: '/times/c-user-center/user', // C端用户
  customer_room: '/times/customer-room-service/custroom', //房产
};

// 请求地址
export default {
  SEND_CODE: option.pub + '/verifycode/api/v1/send', //发送验证码
  CHECK: option.pub + '/verifycode/api/v1/check', //校验验证码

  USER_QUERY: option.c_user + '/api-c/v1/user/query', // 用户信息
  OWNER_CERT: option.c_user + '/api-c/v1/user/realName/add', // 用户认证
  REALNAME_QUERY: option.c_user + '/api-c/v1/user/realName/query', // 查询实人认证状态
  CANCEL_ACCOUNT: option.c_user + '/api-c/v1/user/realName/del', // 取消认证
  MY_ROMLIST: option.customer_room + '/api-c/v1/customer/me/room/List', // 我的房产
  CUSTOMER_LIST: option.customer_room + '/api-c/v1/room/customer/list', // 我的家庭
  CHANGE_PHONENUM: option.c_user + '/api-c/v1/user/me/phone/update', //修改手机号
  DEL_USER: option.c_user + '/api-c/v1/user/del', //注销账户
  ADD_OWNER: option.customer_room + '/api-c/v1/non-owner/add', //添加家人
}

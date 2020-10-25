export let option = {
    login: '/times/auth', // 登录
  
    logout: '/times/api-demo/logout',//退出
  
    space: '/times/space-center/space', //空间管理模块
  
    label: '/times/space-center/space/dir', //标签管理
  
    pub: '/times/pub-center', //数据字典
  
    user: '/times/user-center/user', // 用户管理
  
    organization: '/times/user-center/organization', // 组织架构
  
    user_b: '/times/user-center/b', //B端用户
  
    notice: '/times/notice',//物业公告
  
    project: '/times/user-center/project', //项目

    app_b: '/times/customer-room-service/real',//app_B

    customer:'/times/customer-room-service/custroom'//房产信息
  };
  
  // 请求地址
  export default {
    LOGIN: option.login + '/oauth/token', //登录
    LOGOUT: option.logout + '/logout', //退出登录
    SEND_CODE: option.pub + '/verifycode/api/v1/send', //发送验证码
  
    PERMISSION: '/times/user-center/permission/api/v1/permissions/get', //获取权限信息
    // PORTAL: option.
  
    PROJECT: option.space + '/api/v1/project/list', //项目列表
    PROJECT_DETAIL: option.space + '/api/v1/space-project/block/info', // 项目详情
    LABEL_LIST: option.label + '/api/v1/space-label-dir/query', //标签列表
    LABEL_UPDATE: option.label + '/api/v1/space-label-dir/update', //编辑标签
    LABEL_DELETE: option.label + '/api/v1/space-label-dir/del', //删除标签
    LABEL_ADD: option.label + '/api/v1/space-label-dir/add', //添加标签
    SPACE_PROJECT: option.space + '/api/v1/space-project/list', //空间列表=>项目列表
    SPACE_TREE: option.space + '/api/v1/space/project/tree', //空间树
    SPACE_CHILDREN_LIST: option.space + '/api/v1/space-children/list', //子空间列表
    SPACE_DETAIL: option.space + '/api/v1/space/info', //空间详情
    SPACE_ADD: option.space + '/api/v1/space/add', //添加空间
    SPACE_UPDATE: option.space + '/api/v1/space/edit', //编辑空间
    SPACE_DELETE: option.space + '/api/v1/space/delete', //删除空间
    SPACE_LEVEL: option.label + '/api/v1/space-level/query', //空间层级
    SPACE_ALL_PROJECT: option.space + '/api/v1/space-project/list', //获取全部项目
    GET_PRO_NAME: option.space + '/api/v1/space/getSpaceByIds', //获取项目名称
  
  
    AREA: option.space + '/api/v1/space-area/getPage', //区域列表
    AREA_ADD: option.space + '/api/v1/space-area/add', //添加区域
    AREA_RELATE_SPACE: option.space + '/api/v1/space-area/relateSpace', //区域关联空间
    AREA_CITE: option.space + '/api/v1/space-area/getAreaBuildingUse', //区域引用空间情况
    AREA_DELETE: option.space + '/api/v1/space-area/del', //删除区域
    AREA_UPDATE: option.space + '/api/v1/space-area/update', //编辑区域
  
    HCM_COMPANY_LIST: option.organization + '/api/v1/enterprise/queryHcm', //HCM内部公司列表
    NOT_HCM_COMPANY_LIST: option.organization + '/api/v1/enterprise/queryNotHcm', //非HCM公司列表
    ADD_NOT_HCM: option.organization + '/api/v1/enterprise/add', //添加非HCM公司
    UPDATE_NOT_HCM: option.organization + '/api/v1/enterprise/update', //修改非HCM公司
    DELETE_NOT_HCM: option.organization + '/api/v1/enterprise/delete', //删除非HCM公司
  
    CLIENT_USER_LIST: option.user + '/api/v1/user-c/list', // 用户列表
    CLIENT_USER_UPDATE: option.user + '/api/v1/update', // 编辑用户
    CLIENT_USER_DELETE: option.user + '/api/v1/del', // 删除用户
    CLIENT_USER_PHONE_UPDATE: option.user + '/api/v1/user/phone/update', // 更新用户手机号
    CLIENT_USER_ID_UPDATE: option.user + '/api/v1/user/card/update', // 更新用户id
    CLIENT_USER_ENABLE: option.user + '/api/v1/user/start', // 启用账号
    CLIENT_USER_DISABLE: option.user + '/api/v1/user/stop', // 停用账号
  
    HCM_USER_LIST: option.user_b + '/api/v1/list-employee/query', // hcm用户列表
    HCM_USER_DELETE: option.user_b + '/api/v1/user/delete', // 删除hcm用户
    HCM_USER_CHECK: option.user_b + '/api/v1/user/phone/status', //查看用户状态
    HCM_USER_ADD: option.user + '', // 添加非hcm用户
    AUTH_OPTIONS: option.user_b + '/api/v1/user/get_auth_options', //添加用户查用户角色
    USER_DETAIL: option.user_b + '/api/v1/user/detail', //查用户详细信息
    USER_AUTH: option.user_b + '/api/v1/user/auth', //用户授权
    CREATE_USER: option.user_b + '/api/v1/user/create', //创建用户
    ADD_ORG: option.user_b + '/api/v1/user/add_org', //给用户增加组织机构
  
    ORGANIZATION_TREE: option.organization + '/api/v1/organization/getTree', // 组织列表
  
    USER_INFO: option.user_b + '/api/v1/my/info', // 用户个人信息
    USER_INFO_UPDATE: option.user_b + '/api/v1/user-name/update', // 用户信息更新
    USER_PHONE_UPDATE: option.user_b + '/api/v1/user-phone/update', // 用户手机号更新
    USER_AVATAR_UPDATE: option.user_b + '/api/v1/user-image/update', // 用户头像更新
  
    TYPE: option.notice + '/api/v1/notice/queryNoticeTypes', // 类型管理列表
    TYPE_ADD: option.notice + '/api/v1/notice/addNoticeType', // 添加类型
    TYPE_UPDATE: option.notice + '/api/v1/notice/updateNoticeType', // 编辑类型
    TYPE_DELETE: option.notice + '/api/v1/notice/delNoticeType', // 删除类型
  
    PROPERTY_NOTICE_ADD: option.notice + '/api/v1/notice/addNotice', // 新增公告
    PROPERTY_NOTICE_UPDATE: option.notice + '/api/v1/notice/updateNotice', // 编辑公告
    PROPERTY_NOTICE_INFO: option.notice + '/api/v1/notice/queryNoticeById', // 查询公告详情
    PROPERTY_NOTICE_TYPES: option.notice + '/api/v1/notice/queryAllNoticeType', // 全部公告类型
    PROPERTY_NOTICE_PIC_UPLOAD: option.notice + '/api/v1/notice/upload', // 公告图片上传
  
    MY_PROJECT: option.notice + '/api/v1/notice/queryProjectsByUser', //当前登录用户拥有权限的项目
    PROPERTY_NOTICE: option.notice + '/api/v1/notices/queryNoticeByProID', // 物业公告列表
    PROPERTY_NOTICE_DELETE: option.notice + 'api/v1/notice/delNotice', // 删除物业公告
    PROPERTY_NOTICE_RECALL: option.notice + '/api/v1/notice/updateRecallNotice', // 撤回物业公告

    
    APP_B: option.app_b + '/api/v1/room/customer/list',//房屋列表
    APP_ROOM: option.app_b + '/api/v1/room/get',//房屋基本信息
    APP_JECT: option.app_b + '/api/v1/user/project/list',//房产档案查询用户授权的项目列表
    APP_TOKEN: option.app_b + '/api/v1/token/get',// 获取业主变更信息接口
    APP_TOMER: option.customer + '/api/v1/non-customer/room/del',// 删除住户信息（非业主）
    APP_CUST: option.customer + '/api/v1/room/customer/list',// 根据房间号获取住户列表
  }
  
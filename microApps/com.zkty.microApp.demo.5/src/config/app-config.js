const config = {
    // 开发集成环境
    development: {
      env: 'development',
      // 存储用户状态的cookie
      cookie: {
        userIdKey: 'userId',
        userTokenKey: 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJmYW5qaXVqaXUiLCJzY29wZSI6WyJhbGwiXSwiaWQiOjEsImV4cCI6MTYwMDE4NTEwMCwiYXV0aG9yaXRpZXMiOlsiYXBwX3VzZXJfYWRtaW4iLCJzeXNfYWRtaW4iLCJhbnl0aW1lcyJdLCJqdGkiOiI0ODMyMTNmNy03M2M4LTQyYzAtOGQ3Yy01NGQyZjQxMGMwNmYiLCJjbGllbnRfaWQiOiIyMDM4NTc4MzAifQ.ROwsXzrtyM_GxAc4w-EQV5rJjEHGyZ0XPGzhkk2MsE4n4xmJfCSSRjeuWoXRDUV2nHIZVcoqiuaAXnRKFQGt5k6O5arvV3TT7_8xEAN1UQiCYXWC6-kcsalOyc-_hPm2cqbGXF0mzXPOgs9Xm0sv0JCmMBe_e50Hj89ek82KxKGgvIuUqcxrK3qSwCa74c9mMq-7PIGlf9KV3NBOD_Iulv3sQRF0V3oB7VMs9wzs4hF6z15mDA1zSVTFwz6iSGca4AkJdhAPtheT7MaudzWnqJ53n_nEKOOscR35xb_RB2O2-s3L5ssh3MPFOcw97oO97Z0SvF0hZ436-PUBS7Au5A',
        domain: '',
        expiresDays: 3650 // 过期时间默认10年
      },
      domain: {
        baseDomain: 'http://dev.linli580.com:10000/times/notice/api/v1',
      },
      // 资源配置
      resources: {}
    },
    // 测试环境
    staging: {
      env: 'staging',
      // 存储用户状态的cookie
      cookie: {
        userIdKey: 'userId',
        userTokenKey: 'passToken',
        domain: '',
        expiresDays: 3650 // 过期时间默认10年
      },
      // 域名配置
      domain: {
        baseDomain: '', 
      },
      // 资源配置
      resources: {}
    },
    // 预发布环境
   
    // 生产环境
    production: {
      env: 'production',
      // 存储用户状态的cookie
      cookie: {
        userIdKey: 'userId',
        userTokenKey: 'passToken',
        domain: '',
        expiresDays: 3650 // 过期时间默认10年
      },
      // 域名配置
      domain: {
        baseDomain: '', // 新接口域名
      },
      // 资源配置
      resources: {}
    }
  };
  
  const envConfig = config[process.env.NODE_ENV || 'development'];
  const appConfig = {
    env: 'development',
    basename: process.env.PUBLIC_URL || '', // 前端项目的二级目录
    // 存储用户状态的cookie
    cookie: {
      userIdKey: 'userId',
      userTokenKey: '',
      domain: '',
      expiresDays: 3650 // 过期时间默认10年
    },
    // 域名配置
    domain: {
      baseDomain: '', 
    },
    // 资源配置
    resources: {},
    ...envConfig
  };
  export default appConfig;
  
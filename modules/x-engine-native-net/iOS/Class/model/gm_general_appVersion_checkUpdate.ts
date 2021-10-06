
          const apiName = "gm_general_appVersion_checkUpdate";
          const apiUrlPrefix = ""
          const apiPath = "/gm/general/appVersion/checkUpdate"
          const apiMethod ="POST"
        interface x_api_gm_general_appVersion_checkUpdate_Req  {
// 操作系统（Android、IOS）
os? : string;
// 平台（App、POS等）
platform? : string;
// 版本号
versionCode? : int;
// 版本名称
versionName? : string;
}
interface x_api_gm_general_appVersion_checkUpdate_Res 
{
// 更新摘要
digest? : string;
// 外部地址
externalUrl? : string;
//  是否有更新
isUpdate? : boolean;
// 备注
remark? : string;
// 更新包资源URL
resUrl? : string;
//  更新标题
title? : string;
// 更新类型（1、软更新；2、强制更新；3、热更新）
type? : int;
}

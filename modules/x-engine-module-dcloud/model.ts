// 命名空间
const moduleID = "com.zkty.module.dcloud";

// dto
interface DcloudDTO{
  //小程序appId
  appId:string;
}

interface UniMPDTO {
  appId:string;
  //配置启动小程序时传递的参数
  arguments: Map<string,string>;
  // 路径
  redirectPath: string;
  // 开启后台运行
  enableBackground: boolean;
  //是否开启 show 小程序时的动画效果 默认：true
  showAnimated?:boolean;
  //是否开启 hide 时的动画效果 默认：true
  hideAnimated?:boolean;
}

// 启动小程序
function openUniMP(
  DcloudDTO:DcloudDTO){
  window.openUniMP = () => {
    dcloud.openUniMP({
    appId:'__UNI__1EB976D'
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}

// 预加载后打开小程序
function preloadUniMP(
  UniMPDTO:UniMPDTO = {
    enableBackground:false
  }){
  window.preloadUniMP = (
    
  ) => {
    dcloud.preloadUniMP({
    appId:'__UNI__11E9B73',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}

function openUniMPWithArg(
  UniMPDTO:UniMPDTO = {
    enableBackground:false,
  }){
  window.openUniMPWithArg = () => {
    dcloud.openUniMPWithArg({
    appId:'__UNI__9B75743',
    arguments:{'token':'this is token','refreshtoken':'this is refreshtoken'},
    redirectPath:'pages/component/application/application?token=a&refreshtoken=b',
    enableBackground:false,
  }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
 };
}

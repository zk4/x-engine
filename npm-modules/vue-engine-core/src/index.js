/*
 * @Author: sheng.wang
 * @Date: 2021-05-31 10:47:33
 * @LastEditTime: 2021-05-31 10:58:36
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/npm-modules/vue-engine-core/index.js
 */
export function install (Vue, xengine) {
  Vue.prototype.$engine = xengine;
  // 原生手机状态栏高度
  Vue.prototype.$statusHeight = xengine.api(
    "com.zkty.jsi.device",
    "getStatusBarHeight"
  );
  // 原生手机导航条高度
  Vue.prototype.$navigatorHeight = xengine.api(
    "com.zkty.jsi.device",
    "getNavigationHeight"
  );
  // 原生手机屏幕整体高度
  Vue.prototype.$screenHeight = xengine.api(
    "com.zkty.jsi.device",
    "getScreenHeight"
  );
  // 原生手机底部tabbar高度
  Vue.prototype.$tabbarHeight = xengine.api(
    "com.zkty.jsi.device",
    "getTabbarHeight"
  );
  // 原生手机相关信息
  // this.$tabbarHeight.type          // iOS / android
  // this.$tabbarHeight.systemVersion // 14.4
  // this.$tabbarHeight.language      // en
  // this.$tabbarHeight.UUID          // UUID number
  xengine.api("com.zkty.jsi.device", "getDeviceInfo", {}, (val) => {
    Vue.prototype.$deviceInfo = val;
  });
}


export default install
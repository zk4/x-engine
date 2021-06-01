/*
 * @Author: sheng.wang
 * @Date: 2021-05-10 16:44:39
 * @LastEditTime: 2021-05-29 12:56:24
 * @LastEditors: sheng.wang
 * @Description:
 * @FilePath: /x-engine/npm-modules/x-engine-lifecycle/src/lifeCycle.js
 */
import xengine from "@zkty-team/x-engine-core";

const ON_NATIVE_SHOW = "onNativeShow"; // 原生显示
const ON_WEBVIEW_SHOW = "onWebviewShow"; // 原生显示
const ON_NATIVE_HIDE = "onNativeHide"; // 原生隐藏
const ON_NATIVE_DESTROYED = "onNativeDestroyed"; // 原生销毁

let Vue;
export function install(_Vue) {
  if (Vue !== _Vue) {
    Vue = _Vue;
  }
  Vue.mixin({
    beforeCreate() {
      xengine.onLifecycle((type, payload) => {
        if (type == ON_NATIVE_SHOW) {
          this.onNativeShow?.();
        } else if (type == ON_WEBVIEW_SHOW) {
          this.onNativeShow?.();
        } else if (type == ON_NATIVE_HIDE) {
          this.onNativeHide?.();
        } else if (type == ON_NATIVE_DESTROYED) {
          this.onNativeDestroyed?.();
        }
      });
    },
  });
}

export default {
  install,
};

/*
 * @Author: sheng.wang
 * @Date: 2021-05-20 14:20:45
 * @LastEditTime: 2021-05-28 19:19:51
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/lifeCycle.js
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
    Vue.$$x_engine_broadcast_once = false;
  }
  Vue.mixin({
    beforeCreate() {
      xengine.onLifecycle((type, payload) => {
        xengine.api("com.zkty.jsi.dev", "log", payload);
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
    methods: {
      // 触发生命周期
      triggerLifeCycle(hookName) {
        let that = this;
        if (that.$$x_engine_broadcast_once) {
          let hook = hookName;
          const handlers = that.$options[hook];
          if (handlers) {
            for (let i = 0, j = handlers.length; i < j; i++) {
              handlers[i].call(that);
            }
          }
          if (that._hasHookEvent) {
            that.$emit("hook:" + hook);
          }
        } else {
          that.$$x_engine_broadcast_once = true;
        }
      },
    },
  });
}

export default {
  install,
};

// xengine.broadcastOn((type, payload) => {
//   if (type === LIFECYCLE_EVENT) {
//     if (payload == ON_NATIVE_SHOW) {
//       // that.triggerLifeCycle("mounted");
//       this?.onNativeShow?.();
//     } else if ((payload == payload) == ON_NATIVE_SHOW_WEBVIEW) {
//       // that.triggerLifeCycle("mounted");
//       this?.onNativeShow?.();
//     } else if (payload == ON_NATIVE_HIDE) {
//       // that.triggerLifeCycle("destroyed");
//       this?.onNativeHide?.();
//       // 触发到beforeRouter上
//     } else if (payload == ON_NATIVE_DESTROYED) {
//       // that.triggerLifeCycle("destroyed");
//       this?.onNativeDestroyed?.();
//     }
//   }
// });

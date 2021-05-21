import xengine from "@zkty-team/x-engine-core";

const LIFECYCLE_EVENT = "";
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
      let that = this;
      xengine.onLifecycle((type, payload) => {
        xengine.api("com.zkty.jsi.dev", "log", payload);
        if (type === LIFECYCLE_EVENT) {
          if (type == ON_NATIVE_SHOW) {
            that.triggerLifeCycle("mounted");
          } else if (type == ON_WEBVIEW_SHOW) {
            that.triggerLifeCycle("mounted");
          } else if (type == ON_NATIVE_HIDE) {
            // that.triggerLifeCycle("destroyed");
          } else if (type == ON_NATIVE_DESTROYED) {
            that.triggerLifeCycle("destroyed");
          }
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

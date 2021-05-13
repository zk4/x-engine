/*
 * @Author: sheng.wang
 * @Date: 2021-05-10 16:44:39
 * @LastEditTime: 2021-05-12 15:47:03
 * @LastEditors: sheng.wang
 * @Description:
 * @FilePath: /x-engine/microApps/H5-Sample/src/lifeCycle.js
 */
import xengine from "@zkty-team/x-engine-core";
let Vue;
export function install(_Vue) {
  if (Vue !== _Vue) {
    Vue = _Vue;
    Vue.$$x_engine_broadcast_once = false;
  }
  Vue.mixin({
    beforeCreate() {
      let that = this;
      xengine.broadcastOn((type, payload) => {
        if (type === "@@VUE_LIFECYCLE_EVENT") {
          if (that.$$x_engine_broadcast_once) {
            let hook = "mounted";
            console.log("if的logo");
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
            console.log("else的logo");
            that.$$x_engine_broadcast_once = true;
          }
        }
      });
    },
  });
}
export default {
  install,
};

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
export function install (_Vue) {
  if (Vue !== _Vue) {
    Vue = _Vue;
    Vue.$$x_engine_broadcast_once = false
  }
  Vue.mixin({
    created () {
      let that = this;
      xengine.broadcastOn((type, payload) => {
        console.log('type, payload: ', type, payload);
        if (type === '@@VUE_LIFECYCLE_EVENT') {
          if (that.$$x_engine_broadcast_once) {
            console.log('xxx')
            let hook = "mounted";
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
            that.$$x_engine_broadcast_once = true
          }
        }
        // $$x_engine_broadcast_once 用来解决回退上一个webview出发俩次vue 生命周期


      });
    },
  });
}
export default {
  install,
};

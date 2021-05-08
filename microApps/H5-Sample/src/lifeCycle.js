import xengine from "@zkty-team/x-engine-core";
let Vue = null;
export function install(_Vue) {
  if (Vue !== _Vue) {
    Vue = _Vue;
  }

  Vue.mixin({
    beforeCreate() {
      let that = this;
      xengine.broadcastOn((type, payload) => {
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
      });
    },
  });
}
export default {
  install,
};

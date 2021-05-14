import HEADER from "./src/header";
HEADER.install = function(Vue) {
  Vue.component(HEADER.name, HEADER);
};
export default HEADER;

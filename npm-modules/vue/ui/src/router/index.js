/*
 * @Author: sheng.wang
 * @Date: 2021-05-10 16:44:39
 * @LastEditTime: 2021-05-29 11:44:53
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/npm-modules/x-engine-ui/src/router/index.js
 */
import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);
const routes = [
  {
    path: "/",
    name: "testPage",
    meta: {
      title: "设置收获地址和姓名",
      bgColor: "#ddd",
      // textIsCenter: true,
      isWhiteColor : true
    },
    component: () => import("../views/testPage.vue"),
  }
];

const router = new VueRouter({
  mode: "hash",
  base: process.env.BASE_URL,
  routes,
});

export default router;

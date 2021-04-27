import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);
const routes = [
  {
    path: "/",
    name: "testPage",
    meta: {
      title: "首页",
      bgColor: "#eee",
      textIsCenter: true,
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

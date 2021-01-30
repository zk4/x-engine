import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Gonggao",
    component: () => import('../views/Gonggao.vue')
  },
  {
    path: "/gonggaoDesc",
    name: "GonggaoDesc",
    component: () => import('../views/GonggaoDesc.vue')
  }
];

const router = new VueRouter({
  // mode: "history",
  mode: "hash",
  base: process.env.BASE_URL,
  routes
});

export default router;

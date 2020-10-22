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
  },
  {
    path: "/publicAnnouncement1",
    name: "PublicAnnouncement1",
    component: () => import('../views/PublicAnnouncement1.vue')
  },
  {
    path: "/publicAnnouncement2",
    name: "PublicAnnouncement2",
    component: () => import('../views/PublicAnnouncement2.vue')
  }
];

const router = new VueRouter({
  // mode: "history",
  mode: "hash",
  base: process.env.BASE_URL,
  routes
});

export default router;

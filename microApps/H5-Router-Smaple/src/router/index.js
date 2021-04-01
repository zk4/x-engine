import Vue from "vue"
import VueRouter from "vue-router"
import XEngine from "@zkty-team/x-engine-module-engine"
import ZKTYRouter from './zkty_router'

Vue.use(VueRouter);
const routes = [{
        path: "/",
        name: "testone",
        component: () => import('../views/testone.vue'),
    },
    {
        path: '/testtwo',
        name: 'testtwo',
        component: () => import('../views/testtwo.vue')
    },
    {
        path: '/testthree',
        name: 'testthree',
        component: () => import('../views/testthree.vue')
    },
    {
        path: '/testfour',
        name: 'testfour',
        component: () => import('../views/testfour.vue')
    }
];

const router = new VueRouter({
    mode: "hash",
    base: process.env.BASE_URL,
    routes
});


ZKTYRouter.zktyRouter(VueRouter, XEngine, 'omp');
 
export default router;
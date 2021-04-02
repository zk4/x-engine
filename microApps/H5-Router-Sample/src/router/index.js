import Vue from "vue"
import VueRouter from "vue-router"
import ZKTYRouter from "@zkty-team/vue-router"

Vue.use(VueRouter);
ZKTYRouter(VueRouter, 'omp');

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
    },
    {
        path: '/navHeader1',
        name: 'navHeader1',
        component: () => import('../views/navHeader1.vue')
    },
    {
        path: '/navHeader2',
        name: 'navHeader2',
        component: () => import('../views/navHeader2.vue')
    },
    {
        path: '/skeleton',
        name: 'skeleton',
        component: () => import('../views/skeleton.vue')
    },
    {
        path: '/gifView',
        name: 'gifView',
        component: () => import('../views/gifView.vue')
    }
];

const router = new VueRouter({
    mode: "hash",
    base: process.env.BASE_URL,
    routes
});

export default router;
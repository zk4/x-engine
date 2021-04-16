import Vue from "vue"
import VueRouter from "vue-router"
import XEngineRouter from "@zkty-team/x-engine-router"

Vue.use(VueRouter);

if (process.env.NODE_ENV == 'development') {
    XEngineRouter(VueRouter, 'omp');    
} else {
    XEngineRouter(VueRouter, 'microapp');
}

const routes = [{
        path: "/",
        name: "Home",
        component: () => import('../views/Home.vue'),
    },
    {
        path: '/testone',
        name: 'testone',
        component: () => import('../views/jumpRouter/testone.vue')
    },
    
    {
        path: '/testtwo',
        name: 'testtwo',
        component: () => import('../views/jumpRouter/testtwo.vue')
    },
    {
        path: '/testthree',
        name: 'testthree',
        component: () => import('../views/jumpRouter/testthree.vue')
    },
    {
        path: '/testfour',
        name: 'testfour',
        component: () => import('../views/jumpRouter/testfour.vue')
    },
    {
        path: '/navigation',
        name: 'navigation',
        component: () => import('../views/setNavigation/navigation.vue')
    },
    {
        path: '/customLayout',
        name: 'customLayout',
        component: () => import('../views/customLayout/customLayout.vue')
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
    },
    {
        path: '/refreshData',
        name: 'refreshData',
        component: () => import('../views/refreshData/refreshData.vue')
    },
    {
        path: '/network',
        name: 'network',
        component: () => import('../views/network.vue')
    },
    {
        path: '/modulesIntroduce',
        name: 'modulesIntroduce',
        component: () => import('../views/modulesIntroduce.vue')
    },
    {
        path: '/testVueX',
        name: 'testVueX',
        component: () => import('../views/testVueX.vue')
    }
];

const router = new VueRouter({
    mode: "hash",
    base: process.env.BASE_URL,
    routes
});

export default router;
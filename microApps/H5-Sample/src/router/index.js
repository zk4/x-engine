import Vue from "vue"
import VueRouter from "vue-router"
import XEngineRouter from "../../../../npm-modules/x-engine-router/src/index"

Vue.use(VueRouter);
Vue.use(XEngineRouter, VueRouter);
// if (process.env.NODE_ENV == 'development') {
//     XEngineRouter(VueRouter, 'omp');
// } else {
//     XEngineRouter(VueRouter, 'microapp');
// }

const routes = [{
        path: "/",
        name: "Home",
        meta: {
            title: "首页",
            bgColor: "#ddd",
            textIsCenter: true,
            isWhiteColor: true
        },
        component: () => import('../views/Home.vue'),
    },
    {
        path: '/modulesIntroduce',
        name: 'modulesIntroduce',
        meta: {
            title: "模块介绍",
            customBgcImg: require('@/static/image/navBJ.png')
        },
        component: () => import('../views/modulesIntroduce.vue')
    },
    {
        path: '/testone',
        name: 'testone',
        meta: {
            title: "第一页",
            textIsCenter : true,
            customBgcImg: require('@/static/image/navBJ.png')
        },
        component: () => import('../views/jumpRouter/testone.vue')
    },
    {
        path: '/testtwo',
        name: 'testtwo',
        meta: {
            title: "第二页",
            bgColor: "transparent"
        },
        component: () => import('../views/jumpRouter/testtwo.vue')
    },
    {
        path: '/testthree',
        name: 'testthree',
        meta: {
            title: "第三页",
        },
        component: () => import('../views/jumpRouter/testthree.vue')
    },
    {
        path: '/testfour',
        name: 'testfour',
        meta: {
            title: "第四页"
        },
        component: () => import('../views/jumpRouter/testfour.vue')
    },
    {
        path: '/navigation',
        name: 'navigation',
        meta: {
            isShowHeader: true
        },
        component: () => import('../views/navigation.vue')
    },
    {
        path: '/customLayout',
        name: 'customLayout',
        component: () => import('../views/customLayout.vue')
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
        path: '/localstorage',
        name: 'localstorage',
        meta: {
            title: "存储数据",
        },
        component: () => import('../views/localstorage.vue')
    },
    {
        path: '/refreshData',
        name: 'refreshData',
        meta: {
            title: "刷新数据",
            bgColor: "#a81f24"
        },
        component: () => import('../views/refreshData.vue')
    },
    {
        path: '/network',
        name: 'network',
        component: () => import('../views/network.vue')
    },
    {
        path: '/testVueX',
        name: 'testVueX',
        meta: {
            title: "VueX",
        },
        component: () => import('../views/testVueX.vue')
    },
    {
        path: '/photo',
        name: 'photo',
        meta: {
            title: "拍照选择相册",
        },
        component: () => import('../views/photo.vue')
    },
    {
        path: '/scan',
        name: 'scan',
        meta: {
            title: "扫码",
        },
        component: () => import('../views/scan.vue')
    },
    {
        path: '/search',
        name: 'search',
        meta: {
            isShowHeader: true,
            bgColor: '#ddd'
        },
        component: () => import('../views/search.vue')
    },
    {
        path: '/input',
        name: 'input',
        meta: {
            title:'input'
        },
        component: () => import('../views/input.vue')
    }
];

const router = new VueRouter({
    mode: "hash",
    base: process.env.BASE_URL,
    routes
});

export default router;
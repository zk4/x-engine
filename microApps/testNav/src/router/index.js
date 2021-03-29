import Vue from "vue"
import VueRouter from "vue-router"
import XEngine from "@zkty-team/x-engine-module-engine";
import XEngineNav from "@zkty-team/x-engine-module-nav";

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
];

const router = new VueRouter({
    mode: "hash",
    base: process.env.BASE_URL,
    routes
});

// push
const customRouterPush = VueRouter.prototype.push 
VueRouter.prototype.push = function push(location) {
    if (XEngine.isHybrid()) {
        XEngineNav.navigatorPush({
            url: location.path,
            params: encodeURI(location.query),
            hideNavbar: true,
        });
    } else {
        return customRouterPush.call(this, location);
    }
}

// go
const customRouterGo = VueRouter.prototype.go
VueRouter.prototype.go = function go(location) {
    if (XEngine.isHybrid()) {
        XEngineNav.navigatorBack({
            url: location.path,
            hideNavbar: true,
        })
    } else {
        return customRouterGo.call(this, location);
    }
}

Vue.use(VueRouter);
export default router;
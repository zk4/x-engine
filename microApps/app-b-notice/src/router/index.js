import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
const List = () => import ('@/view/propertyNotice/list');

const routes = [
    {
        path: '/',
        name: 'PropertyNotice',
        component: List,
        meta: {
          keepAlive: true
        }
    },
    {
        path: '/propertyDetail',
        name: 'PropertyNoticeDetail',
        component: resolve => require(['@/view/propertyNotice/detail'],resolve),
        meta: {
          keepAlive: true
        }
    },
    {
        path: '/newsNotice',
        name: 'NewsNotice',
        component: resolve => require(['@/view/propertyNotice/newsNotice'],resolve)
    },
    {
        path: '/addNotice',
        name: 'AddNotice',
        component: resolve => require(['@/view/propertyNotice/addNotice'],resolve)
    },
    {
        path: '/addNoticeDetail',
        name: 'AddNoticeDetail',
        component: resolve => require(['@/view/propertyNotice/addNoticeDetail'],resolve)
    },
    {
        path: '/pushModes',
        name: 'PushModes',
        component: resolve => require(['@/view/propertyNotice/pushModes'],resolve)
    }
]

const router = new VueRouter({
    // mode: 'history',
    mode: 'hash',
    base: process.env.BASE_URL,
    routes
})

export default router

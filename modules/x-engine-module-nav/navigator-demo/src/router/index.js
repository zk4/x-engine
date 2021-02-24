import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const routes = [
    {
        path: '/',
        name: 'testA',
        component: () => import('../views/testA.vue')
    },
    {
        path: '/testB',
        name: 'testB',
        component: () => import('../views/testB.vue')
    },
    {
        path: '/testC',
        name: 'testC',
        component: () => import('../views/testC.vue')
    },
    {
        path: '/testD',
        name: 'testD',
        component: () => import('../views/testD.vue')
    },
    {
        path: '/testE',
        name: 'testE',
        component: () => import('../views/testE.vue')
    }
]

const router = new Router({
    // mode: 'history',
    mode: 'hash',
    base: process.env.BASE_URL,
    routes
})

export default router
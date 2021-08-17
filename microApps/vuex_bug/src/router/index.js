import Vue from 'vue'
import Router from '@zkty-team/vue-router'

Vue.use(Router)

const routes = [
  {
    path: '/',
    redirect: '/a'
  },
  {
    path: '/a',
    name: 'a',
    component: () => import('@/views/a.vue')
  },
  {
    path: '/b',
    name: 'b',
    component: () => import('@/views/b.vue')
  }
]

const router = new Router({
  // mode: 'history',
  mode: 'hash',
  routes
})
export default router

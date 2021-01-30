import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
	{
		path: '/',
		name: 'PropertyNoticed',
		component: resolve => require(['@/view/information/list'], resolve)
	},
	{
		path: '/Property_Notice',
		name: 'PropertyNotice',
		component: resolve => require(['@/view/information/list'], resolve)
	},
	{
		path: '/Property_Detail',
		name: 'PropertyNoticeDetail',
		component: resolve => require(['@/view/information/detail'], resolve),
		children: [{
			path: '/HouseHoldinFormation',
			name: 'householdinformation',
			component: () => import('@/components/householdinformation.vue')
		},
		{
			path: '/OtherInforMation',
			name: 'otherinformation',
			component: () => import('@/components/otherinformation.vue'),
		},
	]
	},
	{
		path: '/CourseByid',
		name: 'coursebyid',
		component: resolve => require(['@/view/information/coursebyid'], resolve)
	},
]

const router = new VueRouter({
	// mode: 'history',
	mode: 'hash',
	base: process.env.BASE_URL,
	routes
})
// GOOD
//router.beforeEach((to, from, next) => {
  //console.log("to",to,"from",from)
  //next()
//})
export default router

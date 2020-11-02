import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
	{
		path: '/',
		name: 'AccountSecure',
		component: () => import ('../view/accountSecure/accountSecure')
	},
	{
		path: '/ownerCert',
		name: 'OwnerCert',
		component: () => import ('../view/accountSecure/ownerCert')
	},
	{
		path: '/hasOwnerCert',
		name: 'HasOwnerCert',
		component: () => import ('../view/accountSecure/hasOwnerCert')
	},
	{
		path: '/ownerCertSuccess',
		name: 'OwnerCertSuccess',
		component: () => import ('../view/accountSecure/ownerCertSuccess')
	},
	{
		path: '/myProperty',
		name: 'MyProperty',
		component: () => import ('../view/accountSecure/myProperty')
	},
	{
		path: '/myFamily',
		name: 'MyFamily',
		component: () => import ('../view/accountSecure/myFamily')
	},
	{
		path: '/addFamily',
		name: 'AddFamily',
		component: () => import ('../view/accountSecure/addFamily')
	},
	{
		path: '/cancelAccount',
		name: 'CancelAccount',
		component: () => import ('../view/accountSecure/cancelAccount')
	},
	{
		path: '/messageList',
		name: 'MessageList',
		component: () => import ('../view/messageCenter/index')
	},
]

const router = new VueRouter({
	// mode: 'history',
	mode: 'hash',
	base: process.env.BASE_URL,
	routes
})

export default router
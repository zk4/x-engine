(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-de31f0f8"],{"47e3":function(t,n,e){},"9a6e":function(t,n,e){"use strict";e.r(n);var s=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"set-page"},[e("div",{ref:"displayBox"}),e("div",{staticClass:"navbar"},[e("van-nav-bar",{attrs:{"left-text":"设置","left-arrow":""},on:{"click-left":t.onClickLeft}})],1),e("div",{staticClass:"content"},[e("van-cell",{staticClass:"account-cell",attrs:{title:"个人资料","is-link":""},on:{click:t.goInfo}}),e("van-cell",{staticClass:"account-cell",attrs:{title:"账号与安全","is-link":""},on:{click:t.goAecurityAccount}}),e("van-cell",{staticClass:"account-cell",attrs:{title:"帮助中心","is-link":""}}),e("van-cell",{staticClass:"account-cell",attrs:{title:"关于我们","is-link":""},on:{click:t.goAbout}}),e("van-cell",{staticClass:"account-cell",attrs:{title:"清除缓存","is-link":"",value:t.value}}),e("van-cell",{staticClass:"account-cell",attrs:{title:"版本号","is-link":"",value:t.appVersion}})],1),t.userInfo?e("div",{staticClass:"subbottom-content"},[e("van-button",{staticClass:"sub-button",attrs:{"data-color":t.canSub,type:"primary",color:"#E8374A","native-type":"submit"},on:{click:t.loginOut}},[t._v("退出登录")])],1):t._e(),e("van-popup",{staticClass:"confirm-pop",model:{value:t.showConfirm,callback:function(n){t.showConfirm=n},expression:"showConfirm"}},[e("div",{staticClass:"content"},[e("p",[t._v("确定退出登录？")]),e("p",{staticClass:"btn"},[e("span",{on:{click:t.cancelConfim}},[t._v("取消")]),e("span",{on:{click:t.confirmBtn}},[t._v("确定")])])])])],1)},c=[],a=(e("96cf"),e("1da1")),o=e("34be"),i=e("9630"),r=e("b91e"),l=e("91ec"),u=e("59bc"),f={name:"SetPage",components:{},mixins:[r["a"]],data:function(){return{value:"3.38M",canSub:!0,showConfirm:!1,userInfo:null,appVersion:null}},mounted:function(){var t=this;o["a"].getStatusHeight({}).then((function(n){t.$refs.displayBox.style.cssText="height: ".concat(n.content,"px;")})),o["a"].getSystemVersion({}).then((function(n){t.appVersion=n.content})),this.getUserInfo(),l["a"].broadcastOn((function(n){t.getUserInfo()}))},methods:{onClickLeft:function(){this.setRouter({isBack:!0,goout:!1})},loginOut:function(){this.showConfirm=!0},cancelConfim:function(){this.showConfirm=!1},confirmBtn:function(){var t=this;return Object(a["a"])(regeneratorRuntime.mark((function n(){var e;return regeneratorRuntime.wrap((function(n){while(1)switch(n.prev=n.next){case 0:return t.showConfirm=!1,n.next=3,i["a"].appLogout();case 3:e=n.sent,console.log("res",e),"success"===e.result&&t.setRouter({isBack:!0});case 6:case"end":return n.stop()}}),n)})))()},getUserInfo:function(){var t=this;return Object(a["a"])(regeneratorRuntime.mark((function n(){var e,s;return regeneratorRuntime.wrap((function(n){while(1)switch(n.prev=n.next){case 0:return n.next=2,u["a"].get({key:"LLBUserInfo",isPublic:!0});case 2:e=n.sent,s=e.result&&JSON.parse(e.result),t.userInfo=s;case 5:case"end":return n.stop()}}),n)})))()},goInfo:function(){this.setRouter({path:"/info"})},goAbout:function(){this.setRouter({path:"/aboutMine"})},goAecurityAccount:function(){this.setRouter({path:"/security-account"})},turnOwenerCert:function(){this.setRouter({path:"/ownerCert"})}}},p=f,v=(e("ee76"),e("2877")),h=Object(v["a"])(p,s,c,!1,null,null,null);n["default"]=h.exports},ee76:function(t,n,e){"use strict";var s=e("47e3"),c=e.n(s);c.a}}]);
(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-29f8829f"],{"28ae":function(e,t,a){"use strict";var n=a("91ec");function i(){return n["a"].use("com.zkty.module.router",[{name:"openTargetRouter",default_args:{type:"h5",uri:"http://192.168.10.51:8081/index.html",path:"",hideNavbar:!1}},{name:"_testh5",default_args:{}},{name:"_testnative",default_args:{}},{name:"_testmicroapp",default_args:{}},{name:"_testmicroapp_version1",default_args:{}},{name:"_testmicroapp_version_not_exist",default_args:{}},{name:"_testmicroapp_path",default_args:{}},{name:"_testmicroapp_path_version1",default_args:{}},{name:"_testmicroapp_path_query",default_args:{}},{name:"_testuni",default_args:{}}])}t["a"]=i()},"34be":function(e,t,a){"use strict";var n=a("91ec");function i(){return n["a"].use("com.zkty.module.device",[{name:"getPhoneType",default_args:{}},{name:"getSystemVersion",default_args:{}},{name:"getUDID",default_args:{}},{name:"getBatteryLevel",default_args:{}},{name:"getPreferredLanguage",default_args:{}},{name:"getScreenWidth",default_args:{}},{name:"getScreenHeight",default_args:{}},{name:"getSafeAreaTop",default_args:{}},{name:"getSafeAreaBottom",default_args:{}},{name:"getSafeAreaLeft",default_args:{}},{name:"getSafeAreaRight",default_args:{}},{name:"getStatusHeight",default_args:{}},{name:"getNavigationHeight",default_args:{}},{name:"getTabBarHeight",default_args:{}},{name:"devicePhoneCall",default_args:{}},{name:"deviceSendMessage",default_args:{}}])}t["a"]=i()},"91ec":function(e,t,a){"use strict";var n={default:void 0,call:function(e,t,a){if("function"==typeof t&&(a=t,t={}),t={data:void 0===t?null:t},"function"==typeof a){var n="dscb"+window.dscb++;window[n]=a,t._dscbstub=n}t=JSON.stringify(t);var i="";return window._dsbridge?i=_dsbridge.call(e,t):(window._dswk||-1!=navigator.userAgent.indexOf("_dsbridge"))&&(i=prompt("_dsbridge="+e,t)),JSON.parse(i||"{}").data},unregister:function(e){delete window._dsaf._obs[e],delete window._dsaf[e],delete window._dsf._obs[e],delete window._dsf[e]},register:function(e,t,a){a=a?window._dsaf:window._dsf,window._dsInit||(window._dsInit=!0,setTimeout((function(){n.call("_dsb.dsinit")}),0)),"object"==typeof t?a._obs[e]=t:a[e]=t},registerAsyn:function(e,t){this.register(e,t,!0)},hasNativeMethod:function(e,t){return this.call("_dsb.hasNativeMethod",{name:e,type:t||"all"})},disableJavascriptDialogBlock:function(e){this.call("_dsb.disableJavascriptDialogBlock",{disable:!1!==e})}};(function(){window._dsf||(window["_dsf"]={_obs:{}},window["_dsaf"]={_obs:{}},window["dscb"]=0,window["dsBridge"]=n,window["close"]=function(){n.call("_dsb.closePage")},window["_handleMessageFromNative"]=function(e){var t=JSON.parse(e.data),a={id:e.callbackId,complete:!0},i=this._dsf[e.method],o=this._dsaf[e.method],r=function(e,i){a.data=e.apply(i,t),n.call("_dsb.returnValue",a)},s=function(e,i){t.push((function(e,t){a.data=e,a.complete=!1!==t,n.call("_dsb.returnValue",a)})),e.apply(i,t)};if(i)r(i,this._dsf);else if(o)s(o,this._dsaf);else if(i=e.method.split("."),!(2>i.length)){e=i.pop();i=i.join("."),o=this._dsf._obs,o=o[i]||{};var d=o[e];d&&"function"==typeof d?r(d,o):(o=this._dsaf._obs,o=o[i]||{},(d=o[e])&&"function"==typeof d&&s(d,o))}},n.register("_hasJavascriptMethod",(function(e,t){return t=e.split("."),2>t.length?!(!_dsf[t]&&!_dsaf[t]):(e=t.pop(),t=t.join("."),(t=_dsf._obs[t]||_dsaf._obs[t])&&!!t[e])})))})();var i=n;const o=new Set([]),r={};function s(e){return e&&"[object Function]"==={}.toString.call(e)}function d(e){return null!==e&&("function"===typeof e||"object"===typeof e)}function l(e){return"[object String]"===Object.prototype.toString.call(e)}function u(){return window&&!0===window._dswk}let c={patch:r,platfrom:m(),hybrid:!0,isHybrid:u,bridge:i,use:h,broadcastOn:_,broadcastOff:f};function f(){c.bridge.unregister("com.zkty.module.engine.broadcast")}function _(e){c.bridge.register("com.zkty.module.engine.broadcast",t=>e(t))}let g=0;function h(e,t){if(o.has(e))throw e+',注册无效,模块已存在,xengine.use("'+e+'") 只允许调用一次;';o.add(e),console.log(e+",js 注册成功");let a=function(t,a){if(a.hasOwnProperty("__event__")){g++;let n=a["__event__"];if(!s(n))throw"__event__ 必须为函数";a["__event__"]=e+"."+t+".__event__"+g,c.bridge.register(a["__event__"],e=>n(e))}if(t.startsWith("sync"))return c.bridge.call(e+"."+t,a);{let n=new Promise((n,i)=>{const o="x-engine 0.1.0 将不再支持 promise,改用参数里的　__ret__做为异步返回值,以支持多次返回.或者直接调用函数同步返回";console.warn(o),c.bridge.call(e+"."+t,a,(function(e){if(n(e),a["__ret__"])return a["__ret__"](e)}))});return n}};return t.reduce((e,t,n)=>{if(d(t))e[t.name]=e=>a(t.name,{...t.default_args,...e});else{if(!l(t))throw"仅支持 string 与 {name:xxx, default_args:{...}}";e[t]=e=>a(t,e)}return e},{})}function m(){var e=navigator.userAgent,t=/(?:Windows Phone)/.test(e),a=/(?:SymbianOS)/.test(e)||t,n=/(?:Android)/.test(e),i=/(?:Firefox)/.test(e),o=(/(?:Chrome|CriOS)/.test(e),/(?:iPad|PlayBook)/.test(e)||n&&!/(?:Mobile)/.test(e)||i&&/(?:Tablet)/.test(e)),r=/(?:iPhone)/.test(e)&&!o,s=!r&&!n&&!a;return{isTablet:o,isPhone:r,isAndroid:n,isPc:s}}function p(e){if(judgeDeviceType.isIOS&&(e.addEventListener("focus",(function(){console.log("IOS 键盘弹起啦！")}),!1),e.addEventListener("blur",()=>{console.log("IOS 键盘收起啦！")})),judgeDeviceType.isAndroid){var t=document.documentElement.clientHeight||document.body.clientHeight;window.addEventListener("resize",(function(){var e=document.documentElement.clientHeight||document.body.clientHeight;t<e?console.log("Android 键盘收起啦！"):console.log("Android 键盘弹起啦！"),t=e}),!1)}}Object.defineProperty(c,"bridge",{get(){return i},set:function(){throw"dsbridge不能被修改"}});for(var v=document.querySelectorAll(".input"),b=0;b<v.length;b++)p(v[b]);r.disableDoubleTapScroll=function(e){e=e||500,console.log("禁用双击滑动,两次点击冷却时间为"+e+" ms");var t=navigator.userAgent.toLowerCase(),a=null;(t.indexOf("iphone")>=0||t.indexOf("ipad")>=0)&&document.body.addEventListener("touchend",(function(t){var n=(new Date).getTime();a=a||n+1;var i=n-a;if(i<e&&i>0)return t.preventDefault(),!1;a=n}),!1)};t["a"]=c},a946:function(e,t,a){"use strict";var n=a("91ec");function i(){return n["a"].use("com.zkty.module.nav",[{name:"setNavTitle",default_args:{title:"title",titleColor:"#000000",titleSize:16}},{name:"setNavLeftBtn",default_args:{title:"",titleColor:"#000000",titleSize:16,icon:"",iconSize:["20","20"]}},{name:"setNavRightBtn",default_args:{title:"right",titleColor:"#000000",titleSize:16,icon:"",iconSize:["20","20"]}},{name:"setNavRightMenuBtn",default_args:{title:"menu",titleColor:"#000000",titleSize:16,icon:"",iconSize:["20","20"],popWidth:"200",showMenuImg:"false",popList:[{icon:"",iconSize:"20",title:"1"},{icon:"",iconSize:"20",title:"2"},{icon:"",iconSize:"20",title:"3"}]}},{name:"setNavRightMoreBtn",default_args:{btns:[{title:"right1",titleColor:"#000000",titleSize:16,iconSize:["20","20"]},{title:"",icon:"/assets/search.png",titleColor:"#000000",titleSize:16,iconSize:["20","20"]}]}},{name:"navigatorPush",default_args:{url:"",hideNavbar:!1}},{name:"navigatorBack",default_args:{url:"",hideNavbar:!1}},{name:"setNavSearchBar",default_args:{cornerRadius:5,backgroundColor:"#FF0000",iconSearch:"",iconSearchSize:[20,20],iconClear:"",iconClearSize:[20,20],textColor:"#000000",fontSize:16,placeHolder:"默认文字",placeHolderFontSize:16,isInput:!0,becomeFirstResponder:!1}},{name:"setSearchBarHidden",default_args:{}},{name:"setNavBarHidden",default_args:{}},{name:"removeHistoryPage",default_args:{}}])}t["a"]=i()},b91e:function(e,t,a){"use strict";var n=a("28ae"),i=a("a946");t["a"]={methods:{setRouter:function(e){var t=e.path,a=void 0===t?"":t,o=e.type,r=void 0===o?"h5":o,s=e.fallback,d=void 0===s?"":s,l=e.uri,u=void 0===l?"":l,c=e.query,f=void 0===c?"":c,_=e.navPath,g=void 0===_?"/":_,h=e.routerPush,m=void 0===h||h,p=e.isBack,v=void 0!==p&&p,b=e.hideNavbar,w=void 0===b||b,S=e.goout,y=void 0===S||S;this.$isDebug?m?v?i["a"].navigatorBack({url:a,hideNavbar:w}):i["a"].navigatorPush({url:a,params:encodeURI(f),hideNavbar:w}):n["a"].openTargetRouter({type:r,uri:u,fallback:d,path:g}):y?this.$router.push({path:a,query:f}):this.$router.go(-1)}}}}}]);
(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-4a5e8dfa"],{"43d7":function(e,t,n){"use strict";n("78cb")},"78cb":function(e,t,n){var i=n("c6cd4");i.__esModule&&(i=i.default),"string"===typeof i&&(i=[[e.i,i,""]]),i.locals&&(e.exports=i.locals);var o=n("499e").default;o("4cc2f998",i,!0,{sourceMap:!1,shadowMode:!1})},"91ec":function(e,t,n){"use strict";var i={default:void 0,call:function(e,t,n){if("function"==typeof t&&(n=t,t={}),t={data:void 0===t?null:t},"function"==typeof n){var i="dscb"+window.dscb++;window[i]=n,t._dscbstub=i}t=JSON.stringify(t);var o="";return window._dsbridge?o=_dsbridge.call(e,t):(window._dswk||-1!=navigator.userAgent.indexOf("_dsbridge"))&&(o=prompt("_dsbridge="+e,t)),JSON.parse(o||"{}").data},unregister:function(e){delete window._dsaf._obs[e],delete window._dsaf[e],delete window._dsf._obs[e],delete window._dsf[e]},register:function(e,t,n){n=n?window._dsaf:window._dsf,window._dsInit||(window._dsInit=!0,setTimeout((function(){i.call("_dsb.dsinit")}),0)),"object"==typeof t?n._obs[e]=t:n[e]=t},registerAsyn:function(e,t){this.register(e,t,!0)},hasNativeMethod:function(e,t){return this.call("_dsb.hasNativeMethod",{name:e,type:t||"all"})},disableJavascriptDialogBlock:function(e){this.call("_dsb.disableJavascriptDialogBlock",{disable:!1!==e})}};(function(){window._dsf||(window["_dsf"]={_obs:{}},window["_dsaf"]={_obs:{}},window["dscb"]=0,window["dsBridge"]=i,window["close"]=function(){i.call("_dsb.closePage")},window["_handleMessageFromNative"]=function(e){var t=JSON.parse(e.data),n={id:e.callbackId,complete:!0},o=this._dsf[e.method],s=this._dsaf[e.method],r=function(e,o){n.data=e.apply(o,t),i.call("_dsb.returnValue",n)},a=function(e,o){t.push((function(e,t){n.data=e,n.complete=!1!==t,i.call("_dsb.returnValue",n)})),e.apply(o,t)};if(o)r(o,this._dsf);else if(s)a(s,this._dsaf);else if(o=e.method.split("."),!(2>o.length)){e=o.pop();o=o.join("."),s=this._dsf._obs,s=s[o]||{};var d=s[e];d&&"function"==typeof d?r(d,s):(s=this._dsaf._obs,s=s[o]||{},(d=s[e])&&"function"==typeof d&&a(d,s))}},i.register("_hasJavascriptMethod",(function(e,t){return t=e.split("."),2>t.length?!(!_dsf[t]&&!_dsaf[t]):(e=t.pop(),t=t.join("."),(t=_dsf._obs[t]||_dsaf._obs[t])&&!!t[e])})))})();var o=i;const s=new Set([]),r={};function a(e){return e&&"[object Function]"==={}.toString.call(e)}function d(e){return null!==e&&("function"===typeof e||"object"===typeof e)}function c(e){return"[object String]"===Object.prototype.toString.call(e)}function l(){return window&&!0===window._dswk}let u={patch:r,platform:w(),hybrid:!0,isHybrid:l,bridge:o,use:v,api:_,broadcastOn:b,broadcastOff:g,assert:f};function f(e,t){document.getElementById(e).style.backgroundColor=t?"green":"red"}function _(e,t,n,i){if(n.hasOwnProperty("__event__")){p++;let e=n["__event__"];if(!a(e))throw"__event__ 必须为函数";n["__event__"]=ns+"."+t+".__event__"+p,u.bridge.register(n["__event__"],t=>e(t))}return o.call(e+"."+t,n,i)}function g(){u.bridge.unregister("com.zkty.module.engine.broadcast")}function b(e){u.bridge.register("com.zkty.module.engine.broadcast",t=>e(t))}let p=0;function v(e,t){if(s.has(e))throw e+',注册无效,模块已存在,xengine.use("'+e+'") 只允许调用一次;';s.add(e),console.log(e+",js 注册成功");let n=function(t,n){if(n.hasOwnProperty("__event__")){p++;let i=n["__event__"];if(!a(i))throw"__event__ 必须为函数";n["__event__"]=e+"."+t+".__event__"+p,u.bridge.register(n["__event__"],e=>i(e))}if(t.startsWith("sync"))return u.bridge.call(e+"."+t,n);{let i=new Promise((i,o)=>{const s="x-engine 0.1.0 将不再支持 promise,改用参数里的　__ret__做为异步返回值,以支持多次返回.或者直接调用函数同步返回";console.warn(s),u.bridge.call(e+"."+t,n,(function(e){if(i(e),n["__ret__"])return n["__ret__"](e)}))});return i}};return t.reduce((e,t,i)=>{if(d(t))e[t.name]=e=>n(t.name,{...t.default_args,...e});else{if(!c(t))throw"仅支持 string 与 {name:xxx, default_args:{...}}";e[t]=e=>n(t,e)}return e},{})}function w(){var e=navigator.userAgent,t=/(?:Windows Phone)/.test(e),n=/(?:SymbianOS)/.test(e)||t,i=/(?:Android)/.test(e),o=/(?:Firefox)/.test(e),s=(/(?:Chrome|CriOS)/.test(e),/(?:iPad|PlayBook)/.test(e)||i&&!/(?:Mobile)/.test(e)||o&&/(?:Tablet)/.test(e)),r=/(?:iPhone)/.test(e)&&!s,a=!r&&!i&&!n;return{isTablet:s,isPhone:r,isAndroid:i,isPc:a}}function h(e){if(judgeDeviceType.isIOS&&(e.addEventListener("focus",(function(){console.log("IOS 键盘弹起啦！")}),!1),e.addEventListener("blur",()=>{console.log("IOS 键盘收起啦！")})),judgeDeviceType.isAndroid){var t=document.documentElement.clientHeight||document.body.clientHeight;window.addEventListener("resize",(function(){var e=document.documentElement.clientHeight||document.body.clientHeight;t<e?console.log("Android 键盘收起啦！"):console.log("Android 键盘弹起啦！"),t=e}),!1)}}Object.defineProperty(u,"bridge",{get(){return o},set:function(){throw"dsbridge不能被修改"}});for(var m=document.querySelectorAll(".input"),y=0;y<m.length;y++)h(m[y]);r.disableDoubleTapScroll=function(e){e=e||500,console.log("禁用双击滑动,两次点击冷却时间为"+e+" ms");var t=navigator.userAgent.toLowerCase(),n=null;(t.indexOf("iphone")>=0||t.indexOf("ipad")>=0)&&document.body.addEventListener("touchend",(function(t){var i=(new Date).getTime();n=n||i+1;var o=i-n;if(o<e&&o>0)return t.preventDefault(),!1;n=i}),!1)};t["a"]=u},9342:function(e,t,n){"use strict";n.r(t);var i=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"testone-class"},[n("div",{staticStyle:{marginTop:"50px"}},[e._v("设置导航条")]),n("van-button",{attrs:{type:"info",size:"large",round:""},on:{click:e.handlerShowNav}},[e._v("显示导航条")]),n("van-button",{attrs:{type:"warning",size:"large",round:""},on:{click:e.handlerChangeNavTitle}},[e._v("修改导航条文字")]),n("van-button",{attrs:{type:"danger",size:"large",round:""},on:{click:e.handlerHiddenNav}},[e._v("隐藏导航条")])],1)},o=[],s=n("91ec"),r={data:function(){return{}},methods:{handlerShowNav:function(){s["a"].isHybrid()?s["a"].bridge.call("com.zkty.jsi.ui.setNavBarHidden",{isHidden:!1,isAnimation:!0},(function(e){console.log("res :>> ",e)})):alert("请在app端测试该功能.")},handlerChangeNavTitle:function(){s["a"].isHybrid()?s["a"].bridge.call("com.zkty.jsi.ui.setNavTitle",{title:"哦哦哦",titleColor:"#f21811",titleSize:18},(function(e){console.log("res :>> ",e)})):alert("请在app端测试该功能.")},handlerHiddenNav:function(){s["a"].isHybrid()?s["a"].bridge.call("com.zkty.jsi.ui.setNavBarHidden",{isHidden:!0,isAnimation:!0},(function(e){console.log("res :>> ",e)})):alert("请在app端测试该功能.")}}},a=r,d=(n("43d7"),n("2877")),c=Object(d["a"])(a,i,o,!1,null,"1f8808e2",null);t["default"]=c.exports},c6cd4:function(e,t,n){var i=n("24fb");t=i(!1),t.push([e.i,".testone-class[data-v-1f8808e2]{margin:20px}.van-button[data-v-1f8808e2]{margin-top:10px}",""]),e.exports=t}}]);
//# sourceMappingURL=chunk-4a5e8dfa.13a2bb48.js.map
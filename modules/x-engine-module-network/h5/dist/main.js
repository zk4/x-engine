!function(e){var t={};function n(o){if(t[o])return t[o].exports;var i=t[o]={i:o,l:!1,exports:{}};return e[o].call(i.exports,i,i.exports,n),i.l=!0,i.exports}n.m=e,n.c=t,n.d=function(e,t,o){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:o})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var o=Object.create(null);if(n.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var i in e)n.d(o,i,function(t){return e[t]}.bind(null,i));return o},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p="",n(n.s=0)}([function(e,t,n){"use strict";n.r(t);var o={default:void 0,call:function(e,t,n){if("function"==typeof t&&(n=t,t={}),t={data:void 0===t?null:t},"function"==typeof n){var o="dscb"+window.dscb++;window[o]=n,t._dscbstub=o}t=JSON.stringify(t);var i="";return window._dsbridge?i=_dsbridge.call(e,t):(window._dswk||-1!=navigator.userAgent.indexOf("_dsbridge"))&&(i=prompt("_dsbridge="+e,t)),JSON.parse(i||"{}").data},unregister:function(e){delete window._dsaf._obs[e],delete window._dsaf[e],delete window._dsf._obs[e],delete window._dsf[e]},register:function(e,t,n){n=n?window._dsaf:window._dsf,window._dsInit||(window._dsInit=!0,setTimeout((function(){o.call("_dsb.dsinit")}),0)),"object"==typeof t?n._obs[e]=t:n[e]=t},registerAsyn:function(e,t){this.register(e,t,!0)},hasNativeMethod:function(e,t){return this.call("_dsb.hasNativeMethod",{name:e,type:t||"all"})},disableJavascriptDialogBlock:function(e){this.call("_dsb.disableJavascriptDialogBlock",{disable:!1!==e})}};window._dsf||(window._dsf={_obs:{}},window._dsaf={_obs:{}},window.dscb=0,window.dsBridge=o,window.close=function(){o.call("_dsb.closePage")},window._handleMessageFromNative=function(e){var t=JSON.parse(e.data),n={id:e.callbackId,complete:!0},i=this._dsf[e.method],d=this._dsaf[e.method],r=function(e,i){n.data=e.apply(i,t),o.call("_dsb.returnValue",n)},s=function(e,i){t.push((function(e,t){n.data=e,n.complete=!1!==t,o.call("_dsb.returnValue",n)})),e.apply(i,t)};if(i)r(i,this._dsf);else if(d)s(d,this._dsaf);else if(!(2>(i=e.method.split(".")).length)){e=i.pop(),i=i.join(".");var u=(d=(d=this._dsf._obs)[i]||{})[e];u&&"function"==typeof u?r(u,d):(u=(d=(d=this._dsaf._obs)[i]||{})[e])&&"function"==typeof u&&s(u,d)}},o.register("_hasJavascriptMethod",(function(e,t){return 2>(t=e.split(".")).length?!(!_dsf[t]&&!_dsaf[t]):(e=t.pop(),t=t.join("."),(t=_dsf._obs[t]||_dsaf._obs[t])&&!!t[e])})));var i=o;const d=new Set([]),r={};let s={patch:r,platfrom:(u=navigator.userAgent,a=/(?:Windows Phone)/.test(u),l=/(?:SymbianOS)/.test(u)||a,c=/(?:Android)/.test(u),f=/(?:Firefox)/.test(u),/(?:Chrome|CriOS)/.test(u),g=/(?:iPad|PlayBook)/.test(u)||c&&!/(?:Mobile)/.test(u)||f&&/(?:Tablet)/.test(u),_=/(?:iPhone)/.test(u)&&!g,{isTablet:g,isPhone:_,isAndroid:c,isPc:!_&&!c&&!l}),hybrid:!0,isHybrid:function(){return window&&!0===window._dswk},bridge:i,use:function(e,t){if(d.has(e))throw e+',注册无效,模块已存在,xengine.use("'+e+'") 只允许调用一次;';d.add(e),console.log(e+",注册成功");let n=function(t,n){if(n.hasOwnProperty("__event__")){let i=n.__event__;if(!(o=i)||"[object Function]"!=={}.toString.call(o))throw"__event__ 必须为函数";n.__event__=e+"."+t+".__event__",s.bridge.register(n.__event__,e=>i(e))}var o;if(t.startsWith("sync"))return s.bridge.call(e+"."+t,n);return new Promise((o,i)=>{console.error("x-engine 0.1.0 将不再支持 promise,改用参数里的　__ret__做为异步返回值,以支持多次返回.或者直接调用函数同步返回"),s.bridge.call(e+"."+t,n,(function(e){if(o(e),n.__ret__)return n.__ret__(e)}))})};return t.reduce((e,t,o)=>{if(null===(d=t)||"function"!=typeof d&&"object"!=typeof d){if(i=t,"[object String]"!==Object.prototype.toString.call(i))throw"仅支持 string 与 {name:xxx, default_args:{...}}";e[t]=e=>n(t,e)}else e[t.name]=e=>n(t.name,{...t.default_args,...e});var i,d;return e},{})},broadcastOn:function(e){s.bridge.register("com.zkty.module.engine.broadcast",t=>e(t))},broadcastOff:function(){s.bridge.unregister("com.zkty.module.engine.broadcast")}};var u,a,l,c,f,g,_;function p(e){if(judgeDeviceType.isIOS&&(e.addEventListener("focus",(function(){console.log("IOS 键盘弹起啦！")}),!1),e.addEventListener("blur",()=>{console.log("IOS 键盘收起啦！")})),judgeDeviceType.isAndroid){var t=document.documentElement.clientHeight||document.body.clientHeight;window.addEventListener("resize",(function(){var e=document.documentElement.clientHeight||document.body.clientHeight;t<e?console.log("Android 键盘收起啦！"):console.log("Android 键盘弹起啦！"),t=e}),!1)}}Object.defineProperty(s,"bridge",{get:()=>i,set:function(){throw"dsbridge不能被修改"}});for(var m=document.querySelectorAll(".input"),h=0;h<m.length;h++)p(m[h]);r.disableDoubleTapScroll=function(e){e=e||500,console.log("禁用双击滑动,两次点击冷却时间为"+e+" ms");var t=navigator.userAgent.toLowerCase(),n=null;(t.indexOf("iphone")>=0||t.indexOf("ipad")>=0)&&document.body.addEventListener("touchend",(function(t){var o=(new Date).getTime(),i=o-(n=n||o+1);if(i<e&&i>0)return t.preventDefault(),!1;n=o}),!1)};var b=s.use("com.zkty.module.network",[{name:"getRequest",default_args:{url:"",method:"get"}},{name:"postRequest",default_args:{url:"",method:"post"}},{name:"deleteRequest",default_args:{url:"",method:"delete"}},{name:"headRequest",default_args:{url:"",method:"head"}},{name:"putRequest",default_args:{url:"",method:"put"}},{name:"patchRequest",default_args:{url:"",method:"patch"}},{name:"downloadRequest",default_args:{url:"",method:"POST",isNeedBase64:!1}},{name:"uploadRequest",default_args:{url:"",method:"POST"}}]);window.getRequest=()=>{b.getRequest({url:"https://api.mocki.io/v1/b043df5a",method:"get"}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.postRequest=()=>{b.postRequest({url:"http://lihong.utools.club/api/user/login",method:"post",params:{username:"admin",passwork:"e10adc3949ba59abbe56e057f20f883e"}}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.deleteRequest=()=>{b.deleteRequest({url:"https://api.mocki.io/v1/b043df5a",method:"delete"}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.headRequest=()=>{b.headRequest({url:"https://api.mocki.io/v1/b043df5a",method:"head"}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.putRequest=()=>{b.putRequest({url:"https://api.mocki.io/v1/b043df5a",method:"put"}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.patchRequest=()=>{b.patchRequest({url:"https://api.mocki.io/v1/b043df5a",method:"patch"}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})},window.downloadRequest=()=>{b.downloadRequest({url:"http://httpbin.org/image/jpeg",method:"GET",__event__:e=>{document.getElementById("debug_text").innerText="下载进度"+e+"%"}}).then(e=>{document.getElementById("debug_text").innerText="下载成功",b.uploadRequest({url:"http://httpbin.org/post",method:"POST",filename:"custom.png",filepath:e.filePath,__event__:e=>{document.getElementById("debug_text").innerText="上传进度"+e+"%"}}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})})},window.uploadRequest=()=>{b.uploadRequest({url:"http://httpbin.org/post",method:"POST",filename:"custom.png",filepath:""}).then(e=>{document.getElementById("debug_text").innerText=JSON.stringify(e)})}}]);
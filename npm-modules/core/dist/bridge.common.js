function e(){return e=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var o in n)Object.prototype.hasOwnProperty.call(n,o)&&(e[o]=n[o])}return e},e.apply(this,arguments)}function t(e,t){(null==t||t>e.length)&&(t=e.length);for(var n=0,o=new Array(t);n<t;n++)o[n]=e[n];return o}function n(e,n){var o="undefined"!=typeof Symbol&&e[Symbol.iterator]||e["@@iterator"];if(o)return(o=o.call(e)).next.bind(o);if(Array.isArray(e)||(o=function(e,n){if(e){if("string"==typeof e)return t(e,n);var o=Object.prototype.toString.call(e).slice(8,-1);return"Object"===o&&e.constructor&&(o=e.constructor.name),"Map"===o||"Set"===o?Array.from(e):"Arguments"===o||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(o)?t(e,n):void 0}}(e))||n&&e&&"number"==typeof e.length){o&&(e=o);var r=0;return function(){return r>=e.length?{done:!0}:{done:!1,value:e[r++]}}}throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}var o=window,r={default:void 0,call:function(e,t,n){if("function"==typeof t&&(n=t,t={}),t={data:void 0===t?null:t},"function"==typeof n){var r="dscb"+o.dscb++;o[r]=n,t._dscbstub=r}t=JSON.stringify(t);var i="";return o._dsbridge?i=_dsbridge.call(e,t):(o._dswk||-1!=o.navigator.userAgent.indexOf("_dsbridge"))&&o.prompt&&(i=o.prompt("_dsbridge="+e,t)),JSON.parse(i||"{}").data},unregister:function(e){delete o._dsaf._obs[e],delete o._dsaf[e],delete o._dsf._obs[e],delete o._dsf[e]},register:function(e,t,n){n=n?o._dsaf:o._dsf,o._dsInit||(o._dsInit=!0,setTimeout(function(){r.call("_dsb.dsinit")},0)),"object"==typeof t?n._obs[e]=t:n[e]=t},registerAsyn:function(e,t){this.register(e,t,!0)},hasNativeMethod:function(e,t){return this.call("_dsb.hasNativeMethod",{name:e,type:t||"all"})},disableJavascriptDialogBlock:function(e){this.call("_dsb.disableJavascriptDialogBlock",{disable:!1!==e})}};o._dsf||(o._dsf={_obs:{}},o._dsaf={_obs:{}},o.dscb=0,o.dsBridge=r,o.close=function(){r.call("_dsb.closePage")},o._handleMessageFromNative=function(e){var t=JSON.parse(e.data),n={id:e.callbackId,complete:!0},o=this._dsaf[e.method],i=function(e,o){n.data=e.apply(o,t),r.call("_dsb.returnValue",n)},a=function(e,o){t.push(function(e,t){n.data=e,n.complete=!1!==t,r.call("_dsb.returnValue",n)}),e.apply(o,t)};if(s=this._dsf[e.method])i(s,this._dsf);else if(o)a(o,this._dsaf);else if(!(2>(s=e.method.split(".")).length)){e=s.pop();var s=s.join("."),d=(o=(o=this._dsf._obs)[s]||{})[e];d&&"function"==typeof d?i(d,o):(d=(o=(o=this._dsaf._obs)[s]||{})[e])&&"function"==typeof d&&a(d,o)}},r.register("_hasJavascriptMethod",function(e,t){return 2>(t=e.split(".")).length?!(!_dsf[t]&&!_dsaf[t]):(e=t.pop(),t=t.join("."),(t=_dsf._obs[t]||_dsaf._obs[t])&&!!t[e])}));var i=new Set([]),a={},s="undefined"==typeof window?global:window;function d(e){return e&&"[object Function]"==={}.toString.call(e)}var l,c,u,f,_={patch:a,platform:(c=null==s||null==(l=s.navigator)?void 0:l.userAgent,u=/(?:Android)/.test(c),f=/(?:iPhone)/.test(c),{isPhone:f,isAndroid:u,isPc:!f&&!u}),hybrid:!0,isHybrid:function(){return s&&!0===s._dswk},bridge:r,use:function(t,n){if(i.has(t))throw t+',注册无效,模块已存在,xengine.use("'+t+'") 只允许调用一次;';i.add(t),console.log(t+",js 注册成功");var o=function(e,n){if(n.hasOwnProperty("__event__")){p++;var o=n.__event__;if(!d(o))throw"__event__ 必须为函数";n.__event__=t+"."+e+".__event__"+p,_.bridge.register(n.__event__,function(e){return o(e)})}return e.startsWith("sync")?_.bridge.call(t+"."+e,n):new Promise(function(o,r){console.warn("x-engine 0.1.0 将不再支持 promise,改用参数里的　__ret__做为异步返回值,以支持多次返回.或者直接调用函数同步返回"),_.bridge.call(t+"."+e,n,function(e){if(o(e),n.__ret__)return n.__ret__(e)})})};return n.reduce(function(t,n,r){if(null===(i=n)||"function"!=typeof i&&"object"!=typeof i){if("[object String]"!==Object.prototype.toString.call(n))throw"仅支持 string 与 {name:xxx, default_args:{...}}";t[n]=function(e){return o(n,e)}}else t[n.name]=function(t){return o(n.name,e({},n.default_args,t))};var i;return t},{})},api:function(e,t,n,o){if(n&&n.hasOwnProperty("__event__")){p++;var i=n.__event__;if(!d(i))throw"__event__ 必须为函数";n.__event__=ns+"."+t+".__event__"+p,_.bridge.register(n.__event__,function(e){return i(e)})}return r.call(e+"."+t,n,o)},broadcastOn:function(e){b.push(e),_.bridge.register("com.zkty.module.engine.broadcast",function(e){for(var t,o=n(b);!(t=o()).done;)(0,t.value)(e.type,e.payload)})},broadcastOff:function(){_.bridge.unregister("com.zkty.module.engine.broadcast")},assert:function(e,t){"document"in s&&(document.getElementById(e).style.backgroundColor=t?"green":"red")},onLifecycle:function(e){g.push(e)}},g=[];_.bridge.register("com.zkty.jsi.engine.lifecycle.notify",function(e){for(var t,o=n(g);!(t=o()).done;)(0,t.value)(e.type,e.payload);console.log("onlifecycle count:",g.length)});var b=[],p=0;function v(e){if(this.platform.isPhone&&(e.addEventListener("focus",function(){console.log("IOS 键盘弹起啦！")},!1),e.addEventListener("blur",function(){console.log("IOS 键盘收起啦！")})),this.platform.isAndroid){var t,n,o=(null==(t=document)?void 0:t.documentElement.clientHeight)||(null==(n=document)?void 0:n.body.clientHeight);s.addEventListener("resize",function(){var e,t,n=(null==(e=document)?void 0:e.documentElement.clientHeight)||(null==(t=document)?void 0:t.body.clientHeight);o<n?console.log("Android 键盘收起啦！"):console.log("Android 键盘弹起啦！"),o=n},!1)}}Object.defineProperty(_,"bridge",{get:function(){return r},set:function(){throw"dsbridge不能被修改"}});var h=[];"document"in s&&(h=document.querySelectorAll(".input"));for(var y=0;y<h.length;y++)v(h[y]);a.disableDoubleTapScroll=function(e){var t,n;e=e||500,console.log("禁用双击滑动,两次点击冷却时间为"+e+" ms");var o=null==s||null==(t=s.navigator)||null==(n=t.userAgent)?void 0:n.toLowerCase(),r=null;"document"in s&&(o.indexOf("iphone")>=0||o.indexOf("ipad")>=0)&&document.body.addEventListener("touchend",function(t){var n=(new Date).getTime(),o=n-(r=r||n+1);if(o<e&&o>0)return t.preventDefault(),!1;r=n},!1)},module.exports=_;
//# sourceMappingURL=bridge.common.js.map

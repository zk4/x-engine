(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-35f3c993"],{5683:function(e,t,n){var o=n("3c10");t=o(!1),t.push([e.i,".testone-class[data-v-f0f27112]{margin:0 20px}.van-button[data-v-f0f27112]{margin-top:10px}",""]),e.exports=t},"6ab8":function(e,t,n){"use strict";n("f5fe")},"6ef0":function(e,t,n){"use strict";n.r(t);var o=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"testone-class"},[n("div",{staticStyle:{height:"100px"}}),n("van-button",{attrs:{type:"primary",size:"large",round:""},on:{click:e.handlerPush}},[e._v("下一页")]),n("van-button",{attrs:{type:"info",size:"large",round:""},on:{click:e.handlerBack}},[e._v("上一页")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#7232dd"},on:{click:e.handlerOpenMicroApp}},[e._v("跳转其他微应用")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#322144"},on:{click:e.handlerOpenBaidu}},[e._v("跳转http 百度")]),n("van-button",{attrs:{size:"large",round:"",color:"#dda0dd"},on:{click:e.handlerOpenYoutube}},[e._v("跳转https youtube 需翻墙")])],1)},a=[],i={data:function(){return{}},mounted:function(){console.log("windowwindowwindow._dswk",window._dswk)},destroyed:function(){},methods:{onNativeShow:function(){alert("onePageCustom--\x3eonNativeShow"),this.$engine.api("com.zkty.jsi.dev","log","onepage-onNativeShow")},onNativeHide:function(){console.log("onePageCustom--\x3eonNativeHide"),this.$engine.api("com.zkty.jsi.dev","log","onePageCustom--\x3eonNativeHide")},onNativeDestroyed:function(){console.log("onePageCustom--\x3eonNativeDestroyed"),this.$engine.api("com.zkty.jsi.dev","log","onePageCustom--\x3eonNativeDestroyed")},handlerPush:function(){this.$router.push({name:"testtwo",query:{changeNavTitle:"第二页"},params:{id:1,age:18,name:"中文"}})},handlerBack:function(){this.$router.go(-1)},handlerOpenMicroApp:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"microapp",host:"com.gm.microapp.home",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){}))},handlerOpenBaidu:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"http",host:"www.baidu.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){}))},handlerOpenYoutube:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"https",host:"www.youtube.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){}))}}},s=i,r=(n("6ab8"),n("d802")),c=Object(r["a"])(s,o,a,!1,null,"f0f27112",null);t["default"]=c.exports},f5fe:function(e,t,n){var o=n("5683");o.__esModule&&(o=o.default),"string"===typeof o&&(o=[[e.i,o,""]]),o.locals&&(e.exports=o.locals);var a=n("0ed3").default;a("7ea8636a",o,!0,{sourceMap:!1,shadowMode:!1})}}]);
//# sourceMappingURL=chunk-35f3c993.3ec22e75.js.map
(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-713fd7bc"],{1422:function(t,e,n){"use strict";n("603f")},"603f":function(t,e,n){var a=n("906a");a.__esModule&&(a=a.default),"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var o=n("0ed3").default;o("3805b45c",a,!0,{sourceMap:!1,shadowMode:!1})},"6ef0":function(t,e,n){"use strict";n.r(e);var a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"testone-class"},[n("van-button",{attrs:{type:"primary",size:"large",round:""},on:{click:t.handlerPush}},[t._v("下一页")]),n("van-button",{attrs:{type:"info",size:"large",round:""},on:{click:t.handlerBack}},[t._v("上一页")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#7232dd"},on:{click:t.handlerOpenMicroApp}},[t._v("跳转其他微应用")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#322144"},on:{click:t.handlerOpenBaidu}},[t._v("跳转http 百度")]),n("van-button",{attrs:{size:"large",round:"",color:"#dda0dd"},on:{click:t.handlerOpenYoutube}},[t._v("跳转https youtube 需翻墙")])],1)},o=[],r={data:function(){return{}},methods:{handlerPush:function(){this.$router.push({path:"/testtwo",query:{id:1,age:18,name:"中文",changeNavTitle:"haha"}})},handlerBack:function(){this.$router.go(-1)},handlerOpenMicroApp:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"microapp",host:"com.gm.microapp.home",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(t){console.log("res :>> ",t)}))},handlerOpenBaidu:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"http",host:"www.baidu.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(t){console.log("res :>> ",t)}))},handlerOpenYoutube:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"https",host:"www.youtube.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(t){console.log("res :>> ",t)}))}}},s=r,c=(n("1422"),n("2be6")),i=Object(c["a"])(s,a,o,!1,null,"18034c17",null);e["default"]=i.exports},"906a":function(t,e,n){var a=n("3c10");e=a(!1),e.push([t.i,".testone-class[data-v-18034c17]{margin:0 20px}.van-button[data-v-18034c17]{margin-top:10px}",""]),t.exports=e}}]);
//# sourceMappingURL=chunk-713fd7bc.afdcaa83.js.map
(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-728dbf2c"],{"63ed":function(e,t,n){"use strict";n("f89c")},"6ef0":function(e,t,n){"use strict";n.r(t);var o=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"testone-class"},[n("img",{attrs:{src:"data:image/png;base64,"+e.imgurl,alt:""}}),n("van-button",{attrs:{type:"primary",size:"large",round:""},on:{click:e.handlerPush}},[e._v("下一页")]),n("van-button",{attrs:{type:"info",size:"large",round:""},on:{click:e.handlerBack}},[e._v("上一页")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#7232dd"},on:{click:e.handlerOpenMicroApp}},[e._v("跳转其他微应用")]),n("van-button",{attrs:{type:"danger",size:"large",round:"",color:"#322144"},on:{click:e.handlerOpenBaidu}},[e._v("跳转http 百度")]),n("van-button",{attrs:{size:"large",round:"",color:"#dda0dd"},on:{click:e.handlerOpenYoutube}},[e._v("跳转https youtube 需翻墙")])],1)},a=[],r={data:function(){return{}},mounted:function(){console.log("testOnePage--\x3emounted")},methods:{onNativeShow:function(){console.log("textone-page"),console.log("textone-page"),console.log("textone-page"),console.log("textone-page"),console.log("textone-page"),console.log("textone-page")},handlerPush:function(){this.$router.push({path:"/testtwo",query:{id:1,age:18,name:"中文",changeNavTitle:"haha"}})},handlerBack:function(){this.$router.go(-1)},handlerOpenMicroApp:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"microapp",host:"com.gm.microapp.home",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){console.log("res :>> ",e)}))},handlerOpenBaidu:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"http",host:"www.baidu.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){console.log("res :>> ",e)}))},handlerOpenYoutube:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"https",host:"www.youtube.com",pathname:"",fragment:"",params:{hideNavbar:!0}},(function(e){console.log("res :>> ",e)}))},handlerToOtherMicroapp:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"microapp",host:"com.gm.microapp.xxx",pathname:"/",fragment:"/xxx"},(function(e){console.log("res :>> ",e)}))},handlerToOtherMicroappAndQuery:function(){this.$engine.api("com.zkty.jsi.direct","push",{scheme:"microapp",host:"com.gm.microapp.xxx",pathname:"/",fragment:"/xxx",query:{id:1,name:"x-engine"}},(function(e){console.log("res :>> ",e)}))}}},c=r,s=(n("63ed"),n("2877")),i=Object(s["a"])(c,o,a,!1,null,"a457a8d2",null);t["default"]=i.exports},8266:function(e,t,n){var o=n("24fb");t=o(!1),t.push([e.i,".testone-class[data-v-a457a8d2]{margin:0 20px}.van-button[data-v-a457a8d2]{margin-top:10px}",""]),e.exports=t},f89c:function(e,t,n){var o=n("8266");o.__esModule&&(o=o.default),"string"===typeof o&&(o=[[e.i,o,""]]),o.locals&&(e.exports=o.locals);var a=n("499e").default;a("d0a12b7a",o,!0,{sourceMap:!1,shadowMode:!1})}}]);
//# sourceMappingURL=chunk-728dbf2c.8eabdbc1.js.map
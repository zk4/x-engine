(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-4609fe56"],{"9f67":function(e,n,t){var i=t("e49d");i.__esModule&&(i=i.default),"string"===typeof i&&(i=[[e.i,i,""]]),i.locals&&(e.exports=i.locals);var a=t("0ed3").default;a("833c9b88",i,!0,{sourceMap:!1,shadowMode:!1})},cd05:function(e,n,t){"use strict";t("9f67")},e406:function(e,n,t){"use strict";t.r(n);var i=function(){var e=this,n=e.$createElement,t=e._self._c||n;return t("div",{staticClass:"testone-class"},[t("div",{staticStyle:{marginTop:"50px"}},[e._v("设置导航条")]),t("van-button",{attrs:{type:"info",size:"large",round:""},on:{click:e.handlerShowNav}},[e._v("显示导航条")]),t("van-button",{attrs:{type:"warning",size:"large",round:""},on:{click:e.handlerChangeNavTitle}},[e._v("修改导航条文字")]),t("van-button",{attrs:{type:"danger",size:"large",round:""},on:{click:e.handlerHiddenNav}},[e._v("隐藏导航条")])],1)},a=[],o={data:function(){return{}},methods:{handlerShowNav:function(){this.$engine.api("com.zkty.jsi.ui","setNavBarHidden",{isHidden:!1,isAnimation:!0},(function(e){console.log("res :>> ",e)}))},handlerChangeNavTitle:function(){this.$engine.api("com.zkty.jsi.ui","setNavTitle",{title:"哦哦哦",titleColor:"#f21811",titleSize:18},(function(e){console.log("res :>> ",e)}))},handlerHiddenNav:function(){this.$engine.api("com.zkty.jsi.ui","setNavBarHidden",{isHidden:!0,isAnimation:!0},(function(e){console.log("res :>> ",e)}))}}},s=o,r=(t("cd05"),t("2be6")),c=Object(r["a"])(s,i,a,!1,null,"06ff8ee7",null);n["default"]=c.exports},e49d:function(e,n,t){var i=t("3c10");n=i(!1),n.push([e.i,".testone-class[data-v-06ff8ee7]{margin:20px}.van-button[data-v-06ff8ee7]{margin-top:10px}",""]),e.exports=n}}]);
//# sourceMappingURL=chunk-4609fe56.ab7471ca.js.map
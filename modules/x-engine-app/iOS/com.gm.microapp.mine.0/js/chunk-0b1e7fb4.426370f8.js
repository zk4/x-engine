(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-0b1e7fb4"],{"3dcf":function(t,e,n){var o=n("24fb");e=o(!1),e.push([t.i,".skeleton-class{margin-top:20px}.content{background:grey;border-radius:20px;margin-top:200px;margin:50px;height:200px;color:#fff;line-height:200px}.operating{margin-top:50px;display:flex;flex-direction:row}",""]),t.exports=e},5361:function(t,e,n){"use strict";n.r(e);var o=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("div",{style:{marginTop:t.navigatorHeight+"px"}},[n("div",{directives:[{name:"show",rawName:"v-show",value:t.skeletonShow,expression:"skeletonShow"}],staticStyle:{"margin-top":"30px"}},[n("van-skeleton",{attrs:{title:"",avatar:"",round:"",animate:"",row:3}})],1),n("div",{directives:[{name:"show",rawName:"v-show",value:!t.skeletonShow,expression:"!skeletonShow"}],staticStyle:{"margin-top":"50px"}},[n("div",[t._v("老子出现了")])])]),n("div",{staticClass:"content"},[t._v("store中的count为:"+t._s(t.$store.state.count))]),n("div",{staticClass:"operating"},[n("van-button",{attrs:{color:"linear-gradient(to right, #4bb0ff, #6149f6)",size:"large",round:""},on:{click:t.handlerSyncJIA}},[t._v("sync加")]),n("van-button",{attrs:{color:"linear-gradient(to right, #ff6034, #ee0a24)",size:"large",round:""},on:{click:t.handlerSyncJIAN}},[t._v("async减")])],1)])},a=[],i={data:function(){return{navTitle:"骨架屏",skeletonShow:!0}},mounted:function(){var t=this;setTimeout((function(){t.skeletonShow=!1}),3e3)},methods:{handlerHeaderBack:function(){this.$router.go(-1)},handlerHeaderRightBtn:function(){alert("点击的了右上角按钮")},handlerNextpage:function(){this.$router.push({path:"/navHeader"})},handlerSyncJIA:function(){this.$store.commit("jia")},handlerSyncJIAN:function(){this.$store.commit("jian")}}},r=i,s=(n("92f1"),n("2877")),c=Object(s["a"])(r,o,a,!1,null,null,null);e["default"]=c.exports},"92f1":function(t,e,n){"use strict";n("bc49")},bc49:function(t,e,n){var o=n("3dcf");o.__esModule&&(o=o.default),"string"===typeof o&&(o=[[t.i,o,""]]),o.locals&&(t.exports=o.locals);var a=n("499e").default;a("384d5db4",o,!0,{sourceMap:!1,shadowMode:!1})}}]);
//# sourceMappingURL=chunk-0b1e7fb4.426370f8.js.map
(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-12242120"],{"25f0":function(t,e,o){"use strict";var n=o("6eeb"),i=o("825a"),s=o("d039"),r=o("ad6d"),a="toString",c=RegExp.prototype,u=c[a],f=s((function(){return"/a/b"!=u.call({source:"a",flags:"b"})})),l=u.name!=a;(f||l)&&n(RegExp.prototype,a,(function(){var t=i(this),e=String(t.source),o=t.flags,n=String(void 0===o&&t instanceof RegExp&&!("flags"in c)?r.call(t):o);return"/"+e+"/"+n}),{unsafe:!0})},"4d63":function(t,e,o){var n=o("83ab"),i=o("da84"),s=o("94ca"),r=o("7156"),a=o("9bf2").f,c=o("241c").f,u=o("44e7"),f=o("ad6d"),l=o("9f7f"),p=o("6eeb"),d=o("d039"),g=o("69f3").enforce,h=o("2626"),m=o("b622"),v=m("match"),y=i.RegExp,b=y.prototype,x=/a/g,C=/a/g,$=new y(x)!==x,k=l.UNSUPPORTED_Y,w=n&&s("RegExp",!$||k||d((function(){return C[v]=!1,y(x)!=x||y(C)==C||"/a/i"!=y(x,"i")})));if(w){var I=function(t,e){var o,n=this instanceof I,i=u(t),s=void 0===e;if(!n&&i&&t.constructor===I&&s)return t;$?i&&!s&&(t=t.source):t instanceof I&&(s&&(e=f.call(t)),t=t.source),k&&(o=!!e&&e.indexOf("y")>-1,o&&(e=e.replace(/y/g,"")));var a=r($?new y(t,e):y(t,e),n?this:b,I);if(k&&o){var c=g(a);c.sticky=!0}return a},E=function(t){t in I||a(I,t,{configurable:!0,get:function(){return y[t]},set:function(e){y[t]=e}})},L=c(y),N=0;while(L.length>N)E(L[N++]);b.constructor=I,I.prototype=b,p(i,"RegExp",I)}h("RegExp")},5891:function(t,e,o){"use strict";o("88bc")},"88bc":function(t,e,o){},"92a7":function(t,e,o){"use strict";o.r(e);var n=function(){var t=this,e=t.$createElement,o=t._self._c||e;return o("div",[o("GmHeader",{attrs:{hideItem:["center","right"],leftText:"添加物流信息","background-color":"#fff"}}),o("div",{staticClass:"dropdown-box"},[o("p",{staticClass:"module-title"},[t._v("物流公司")]),o("van-field",{ref:"myInput",attrs:{label:"",placeholder:"请选择物流信息"},on:{focus:t.focusInput,input:t.changeInput,blur:t.blurInput},model:{value:t.logisticsCompany,callback:function(e){t.logisticsCompany=e},expression:"logisticsCompany"}}),o("van-dropdown-menu",{attrs:{overlay:!1,"close-on-click-outside":!1}},[o("van-dropdown-item",{ref:"dropMenu",attrs:{options:t.option2},on:{change:t.selectCompany,open:t.openDropMenu},model:{value:t.value1,callback:function(e){t.value1=e},expression:"value1"}})],1),o("p",{staticClass:"module-title"},[t._v("退货单号")]),o("van-field",{ref:"myOrder",attrs:{placeholder:"请输入退货单号",maxlength:"60"},on:{click:t.clickOrder},model:{value:t.textNum,callback:function(e){t.textNum=e},expression:"textNum"}})],1),o("div",{staticClass:"page-bottom"},[o("div",{staticClass:"page-bottom-button",on:{click:t.shareInvite}},[t._v("确定")])])],1)},i=[],s=(o("4d63"),o("ac1f"),o("25f0"),o("4de4"),o("d81d"),{name:"ChooseLogists",components:{},data:function(){return{value1:" ",option1:[],logisticsCompany:"",returnLogisticsId:"",textNum:"",boxShow:!1,option2:[]}},created:function(){this.toast(),this.getLogisticsCompanys()},mounted:function(){document.body.style.backgroundColor="#f9f9f9"},computed:{bottomHeight:function(){return this.$tabbarHeight+"px"}},methods:{clickOrder:function(){this.$refs.myOrder.focus()},blurInput:function(){this.$refs.dropMenu.toggle(),this.$refs.myOrder.focus()},openDropMenu:function(){this.$refs.myInput.focus(),this.$refs.dropMenu.toggle(!0),this.logisticsCompany||(this.option2=this.option1)},changeInput:function(t){var e=t,o=new RegExp(e),n=this.option1.filter((function(t){return o.test(t.text)}));this.option2=n},focusInput:function(){if(this.$refs.dropMenu.toggle(!0),this.logisticsCompany){var t=this.logisticsCompany,e=new RegExp(t),o=this.option1.filter((function(t){return e.test(t.text)}));o?this.$refs.dropMenu.toggle(!0):this.$refs.dropMenu.toggle()}},toast:function(){this.$toast.loading({duration:0,message:"加载中...",forbidClick:!0})},getLogisticsCompanys:function(){var t=this;this.$api.getLogisticsCompanys().then((function(e){if(0===e.code){t.$toast.clear();var o=[];e.data.map((function(t){o.push({text:t.logisticsname,value:t.logisticsId})})),t.option1=o}}))},selectCompany:function(t){var e=this;this.returnLogisticsId=t,this.option1.map((function(o){o.value===t&&(e.logisticsCompany=o.text)}))},confirmBtn:function(){var t=this,e={afterSaleType:this.$route.query.afterSaleType,orderNo:this.$route.query.repairOrderNo,id:this.$route.query.id,returnLogistics:this.logisticsCompany,returnLogisticsOrderNo:this.textNum,returnLogisticsCode:this.returnLogisticsId};this.$api.afterSaleAddlog(e).then((function(e){0===e.code&&(t.$toast("操作成功"),t.$utils.storage.set("refreshDetail",!0),t.$utils.storage.set("refreshList",!0),setTimeout((function(){t.$router.go(-1)}),800))})).catch((function(){}))},shareInvite:function(){this.logisticsCompany?this.textNum?(this.toast(),this.confirmBtn()):this.$toast("请输入退货单号"):this.$toast("请选择物流公司")}}}),r=s,a=(o("5891"),o("2877")),c=Object(a["a"])(r,n,i,!1,null,"5c10f01c",null);e["default"]=c.exports}}]);
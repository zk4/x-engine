(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-eef18e3e"],{"09bb":function(t,e,a){"use strict";var s=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"contents"},[a("p",{staticClass:"title"},[t._v("售后商品")]),a("van-card",{attrs:{desc:t.data.skuSpecValues||t.data.skuSpecsName,title:t.data.skuName,thumb:t.data.mainPicUrl}})],1)},i=[],o={name:"GoodDetails",props:{data:{type:Object,default:function(){}}},components:{},data:function(){return{defaultAvatar:a("ee87")}},created:function(){},computed:{},watch:{},methods:{}},r=o,n=(a("4ced"),a("2877")),l=Object(n["a"])(r,s,i,!1,null,null,null);e["a"]=l.exports},"1afe":function(t,e,a){"use strict";a("5a6d")},"4ced":function(t,e,a){"use strict";a("673f")},"5a43":function(t,e,a){"use strict";a.r(e);var s=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("GmHeader",{attrs:{hideItem:["center","right"],leftText:0==t.$route.query.styleStatus?"申请退款":"申请退货退款","background-color":"#fff"}}),a("div",{staticClass:"after-service"},[a("GoodsDetails",{attrs:{data:t.datas}}),a("div",{staticClass:"contents"},[a("p",{staticClass:"titles"},[t._v("售后商品")]),a("div",{staticClass:"refund-details"},[a("ul",[1==t.$route.query.styleStatus?a("li",{staticClass:"cell",on:{click:t.chooseStyle}},[t._m(0),a("div",{staticClass:"right-cell"},[a("span",{class:""===t.styleValue?"right-text default":"right-text"},[t._v(t._s(""===t.styleValue?"请选择":t.styleValue))]),a("span",{staticClass:"right-icon"})])]):t._e(),0==t.$route.query.styleStatus?a("li",{staticClass:"cell",on:{click:t.chooseStatus}},[t._m(1),a("div",{staticClass:"right-cell"},[a("span",{class:t.goodstatusValue?"right-text":"right-text default"},[t._v(t._s(t.goodstatusValue?t.goodstatusValue:"请选择"))]),a("span",{staticClass:"right-icon"})])]):t._e(),a("li",{staticClass:"cell",on:{click:t.chooseReason}},[t._m(2),a("div",{staticClass:"right-cell"},[a("span",{class:t.reasonValue?"right-text":"right-text default"},[t._v(t._s(t.reasonValue?t.reasonValue:"请选择"))]),a("span",{staticClass:"right-icon"})])]),a("li",{staticClass:"cell"},[t._m(3),a("div",{staticClass:"right-cell"},[a("van-stepper",{attrs:{max:t.buyNum,"disable-input":""},model:{value:t.stepperValue,callback:function(e){t.stepperValue=e},expression:"stepperValue"}})],1)]),a("li",{staticClass:"cell"},[t._m(4),a("div",{staticClass:"right-cell"},[a("span",{staticClass:"right-nums"},[t._v("¥"+t._s(t.data?t.data.orderItemList?(t.data.orderItemList[t.goodIndex].payAmount-t.data.orderItemList[t.goodIndex].freightAmount*t.stepperValue/t.data.orderItemList[t.goodIndex].number).toFixed(2):(t.salePaidAmount*t.stepperValue/t.saleBuyNum).toFixed(2):""))])])])])])]),a("div",{staticClass:"contents"},[a("p",{staticClass:"title"},[t._v("补充描述和凭证")]),a("van-field",{staticClass:"message",attrs:{rows:"3",autosize:"",type:"textarea",maxlength:"50",placeholder:"描述一下吧~","show-word-limit":""},model:{value:t.message,callback:function(e){t.message=e},expression:"message"}}),a("div",{staticClass:"imgs-upload"},[a("van-row",{staticClass:"img-list",attrs:{type:"flex",gutter:"8"}},[t._l(t.reviewsImg,(function(e,s){return a("van-col",{key:s,staticStyle:{position:"relative"},attrs:{span:"8"}},[a("van-image",{staticClass:"reviews-img",attrs:{src:e,"error-icon":t.defaultAvatar,fit:"cover"},on:{click:function(e){return t.reviewImg(t.reviewsImg,s)}}}),a("span",{staticClass:"dele-icon",on:{click:function(e){return t.deleImg(s)}}})],1)})),t.reviewsImg.length<3?a("van-col",{attrs:{span:"8"}},[t.environment?a("van-uploader",{attrs:{"after-read":t.afterRead}}):t._e(),a("div",{staticClass:"upload-btn",on:{click:t.showPhoto}},[a("span",{staticClass:"phone-icon"}),a("p",[t._v("上传图片")])])],1):t._e()],2),a("p",{staticClass:"uptips"},[t._v("最多可上传3张")])],1)],1),a("div",{staticClass:"bottom-btn",style:{height:t.bottomHeight}},[a("van-button",{staticClass:"btn",attrs:{type:"primary"},on:{click:t.createService}},[t._v("提交")])],1),a("ShowDialog",{ref:"showDialog",attrs:{showDialog:t.showDialog,dataArr:t.dataArr,dialogTitle:t.dialogTitle},on:{cancelConfim:t.cancelConfim,confirmBtn:t.confirmBtn,setshowDialog:t.setshowDialog}})],1)],1)},i=[function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"left-cell"},[a("span",{staticClass:"tips-icon"},[t._v("*")]),a("span",{staticClass:"title"},[t._v("退货方式")])])},function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"left-cell"},[a("span",{staticClass:"tips-icon"},[t._v("*")]),a("span",{staticClass:"title"},[t._v("货物状态")])])},function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"left-cell"},[a("span",{staticClass:"tips-icon"},[t._v("*")]),a("span",{staticClass:"title"},[t._v("退款原因")])])},function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"left-cell"},[a("span",{staticClass:"tips-icon"},[t._v("*")]),a("span",{staticClass:"title"},[t._v("商品数量")])])},function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"left-cell"},[a("span",{staticClass:"tips-icon"},[t._v("*")]),a("span",{staticClass:"title"},[t._v("退款金额")])])}],o=(a("d81d"),a("d3b7"),a("a434"),a("ac1f"),a("1276"),a("28a2")),r=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("van-popup",{staticClass:"show-dialog",attrs:{position:"bottom"},model:{value:t.showDialog,callback:function(e){t.showDialog=e},expression:"showDialog"}},[a("div",{staticClass:"content"},[a("p",{staticClass:"title"},[t._v(t._s(t.dialogTitle))]),a("div",{staticClass:"container"},[a("van-radio-group",{staticClass:"choose-style-radio",on:{change:t.chooseStyle},model:{value:t.radio,callback:function(e){t.radio=e},expression:"radio"}},t._l(t.dataArr,(function(e,s){return a("van-cell",{key:s,attrs:{title:e.value,clickable:""},on:{click:function(a){return t.chooseRadio(e)}},scopedSlots:t._u([{key:"right-icon",fn:function(){return[a("van-radio",{attrs:{name:e.id,"checked-color":"#FFA824","icon-size":"16px"}})]},proxy:!0}],null,!0)})})),1)],1)]),a("p",{staticClass:"dialog-btn",style:{height:t.bottomHeight}},[a("van-button",{staticClass:"cancel-btn",attrs:{type:"primary"},on:{click:t.cancelConfim}},[t._v("取消")]),a("van-button",{staticClass:"btn",attrs:{type:"primary"},on:{click:t.confirmBtn}},[t._v("确定")])],1)])},n=[],l={name:"ShowDialog",props:{dialogTitle:{type:String,default:""},dialogValue:{type:String,default:""},dataArr:{type:Array,default:function(){return[]}}},components:{},data:function(){return{radio:"0",showDialog:!1,defaultValue:"",data:""}},watch:{showDialog:function(t){this.$emit("setshowDialog",t)}},computed:{bottomHeight:function(){return this.$tabbarHeight+"px"}},methods:{cancelConfim:function(){this.$emit("cancelConfim")},confirmBtn:function(){this.$emit("confirmBtn",this.data)},chooseStyle:function(t){this.radio=t},chooseRadio:function(t){this.data=t,this.radio=t.id,this.defaultValue=t.value,this.status=t.status}}},d=l,c=(a("c61c"),a("2877")),u=Object(c["a"])(d,r,n,!1,null,null,null),h=u.exports,A=a("09bb"),f=a("365c"),m=a("ee87"),p={name:"ApplyRefund",components:{ShowDialog:h,GoodsDetails:A["a"]},data:function(){return{saleBuyNum:"",salePaidAmount:"",goodIndex:0,environment:this.$utils.isMiniprogram(),orderNo:this.$route.query.orderNo,orderType:this.$route.query.orderType,data:[],datas:{},defaultAvatar:m,buyNum:"",stepperValue:1,reviewsImg:[],message:"",showDialog:!1,dialogTitle:"",type:"",styleValue:"自行寄回",reasonValue:"",goodstatusValue:"",styleRadio:"",reasonRadio:"",goodstatusRadio:"",reasonId:"",serviceStatus:this.$route.query.styleStatus,goodsStatus:"1",styleArr:[{id:1,status:"1",value:"自行寄回"}],reasonArr:[],receivingArr:[{id:1,status:"0",value:"已收到货物"},{id:2,status:"1",value:"未收到货物"}],dataArr:[],orderItemList:[]}},created:function(){this.toast();var t=this.$route.query.from;"service"===t?this.serviceDetail():"afterSale"===t?this.getAfterSaleDetail():"catering"===t?this.cateringDetail():this.getGoodsDetail(),this.getRefundReasonList(t)},computed:{bottomHeight:function(){return this.$tabbarHeight+"px"}},methods:{getRefundReasonList:function(t){var e=this,a={type:1};"service"===t&&(a.caCode="005"),"afterSale"===t&&(a.caCode="002",this.$route.query.caCode&&("CONSUME"===this.$route.query.caCode.substring(0,7)&&(a.caCode="002"),"CATERING"===this.$route.query.caCode.substring(0,8)&&(a.caCode="001"),"SERVICE"===this.$route.query.caCode.substring(0,7)&&(a.caCode="005"))),"catering"===t&&(a.caCode="001"),this.$api.refundReasonList(a).then((function(t){if(0===t.code){var a=t.data.infos,s=[];a.map((function(t){var e={};e.id=t.id,e.value=t.reasonName,s.push(e)})),e.reasonArr=s}}))},toast:function(){this.$toast.loading({duration:0,type:"loading",message:"加载中...",forbidClick:!0})},getAfterSaleDetail:function(){var t=this,e={afterSaleNo:this.$route.query.afterSaleNo};this.$api.afterSaleDetail(e).then((function(e){0===e.code&&(t.$toast.clear(),t.data.push(e.data),t.datas=JSON.parse(e.data.afterSaleSkusJson)[0],t.salePaidAmount=e.data.itemList[0].orderInfo.payAmount,t.saleBuyNum=e.data.itemList[0].buyNum,t.buyNum=t.datas.buyNum)})).catch((function(){}))},serviceDetail:function(){var t=this,e={orderNo:this.orderNo,orderType:this.orderType};f["a"].serviceDetail(e).then((function(e){0===e.code&&(t.$toast.clear(),t.data=e.data,e.data.orderItemList.map((function(a,s){a.orderItemNo===t.$route.query.orderItemNo&&(t.datas=a,t.goodIndex=s,t.buyNum=e.data?e.data.orderItemList[s].number:"")})))})).finally((function(){}))},getGoodsDetail:function(){var t=this,e={orderNo:this.orderNo,orderType:this.orderType};f["a"].ORDERDetail(e).then((function(e){0===e.code&&(t.$toast.clear(),t.data=e.data,t.$route.query.orderItemNo?e.data.orderItemList.map((function(e,a){e.orderItemNo===t.$route.query.orderItemNo&&(t.goodIndex=a,t.datas=e)})):t.datas=e.data.orderItemList[0],t.buyNum=e.data?e.data.orderItemList[0].number:"")})).catch((function(){}))},cateringDetail:function(){var t=this,e={orderNo:this.orderNo,orderType:this.orderType};f["a"].getOrderDetail(e).then((function(e){t.data=e.data,t.$toast.clear(),e.data.orderItemList.map((function(a,s){a.orderItemNo===t.$route.query.orderItemNo&&(t.datas=a,t.goodIndex=s,t.buyNum=e.data?e.data.orderItemList[s].number:"")}))})).catch((function(){}))},deleImg:function(t){this.reviewsImg.splice(t,1)},reviewImg:function(t,e){Object(o["a"])({images:t,startPosition:e,showIndex:!1,closeable:!0,closeIcon:"arrow-left",closeIconPosition:"top-left"})},setshowDialog:function(t){this.showDialog=t},chooseStyle:function(){},chooseStatus:function(){this.$refs.showDialog.showDialog=!0,this.$refs.showDialog.radio=this.goodstatusRadio,this.type="status",this.dialogTitle="货物状态",this.dataArr=this.receivingArr,this.showDialog=!0},chooseReason:function(){this.$refs.showDialog.showDialog=!0,this.$refs.showDialog.radio=this.reasonRadio,this.type="reason",this.dialogTitle="请选择退款原因",this.dataArr=this.reasonArr,this.showDialog=!0},confirmBtn:function(t){this.$refs.showDialog.showDialog=!1,"style"===this.type?(this.styleValue=t.value,this.styleRadio=t.radio,this.styleStatus=t.status):"status"===this.type?(this.goodstatusValue=t.value,this.goodstatusRadio=t.radio,this.goodsStatus=t.status):(this.reasonValue=t.value,this.reasonRadio=t.radio,this.reasonId=t.id),this.$refs.showDialog.data=""},cancelConfim:function(){this.$refs.showDialog.showDialog=!1},afterRead:function(t){this.upLoadImg(t.file.name,t.content.split(",")[1])},showPhoto:function(){var t=this;this.reviewsImg.length<3?this.$engine.api("com.zkty.jsi.camera","openImagePicker",{allowsEditing:!1,savePhotosAlbum:!1,cameraFlashMode:-1,cameraDevice:"back",photoCount:1,args:{bytes:"100"},isbase64:!0},(function(e){t.upLoadImg(JSON.parse(e).data[0].fileName,JSON.parse(e).data[0].retImage)})):this.$toast("最多可上传3张")},upLoadImg:function(t,e){var a=this;this.toast();var s={fileName:t,base64Str:e};f["a"].uploadBase64(s).then((function(t){0===t.code&&(a.$toast.clear(),a.reviewsImg.push(t.data.res.url))})).finally((function(t){}))},createService:function(){var t=this;if("0"!==this.goodstatusValue||"请选择"!==this.goodstatusValue&&""!==this.goodstatusValue)if(""!==this.styleValue&&this.styleValue&&"请选择"!==this.styleValue)if(""!==this.reasonValue&&this.reasonValue&&"请选择"!==this.reasonValue){var e=[],a={};if("afterSale"!==this.$route.query.from)for(var s=0;s<this.data.orderItemList.length;s++)this.data.orderItemList[s].orderItemNo===this.$route.query.orderItemNo&&(a.afterSaleNumber=this.stepperValue,a.buyNum=this.data.orderItemList[s].number,a.skuClassName=this.data.orderItemList[s].skuClassName,a.skuCode=this.data.orderItemList[s].skuCode,a.skuName=this.data.orderItemList[s].skuName,a.skuSpecsName=this.data.orderItemList[s].skuSpecJson,a.orderItemNo=this.data.orderItemList[s].orderItemNo,e.push(a));if(this.toast(),"add"===this.$route.query.type){var i={serviceOrders:[{returnMode:0,afterSaleType:this.serviceStatus,cargoState:this.goodsStatus,issueDesc:this.message,mallCode:this.data.mallCode,mallName:this.data.mallName,merCode:this.data.merCode,merName:this.data.merName,orderNo:this.data.orderNo,orderPayType:"NORMAL"===this.data.orderPayType?0:1,orderType:this.data.orderType,picUrl:JSON.stringify(this.reviewsImg),refundReason:this.reasonValue,refundReasonId:this.reasonId,serviceOrderItems:e,shopCode:this.data.shopCode,shopName:this.$shopAliasName(this.data),tradeNo:this.data.tradeNo,userId:this.data.userId,userName:this.data.userName,userPhone:this.data.userPhone,repairId:this.$route.query.repairId}]};f["a"].serviceApply(i).then((function(e){0===e.code&&(t.$toast("提交成功"),t.$utils.storage.set("refreshDetail",!0),setTimeout((function(){t.$router.go(-2)}),800))})).finally((function(){}))}else{var o={repairId:this.$route.query.repairId,serviceOrder:{returnMode:0,afterSaleType:this.serviceStatus,cargoState:"1",issueDesc:this.message,mallCode:this.data.mallCode,mallName:this.data.mallName,merCode:this.data.merCode,merName:this.data.merName,orderNo:this.data.orderNo,orderPayType:"NORMAL"===this.data.orderPayType?0:1,orderType:this.data.orderType,picUrl:JSON.stringify(this.reviewsImg),refundReason:this.reasonValue,refundReasonId:this.reasonId,shopCode:this.data.shopCode,shopName:this.$shopAliasName(this.data),tradeNo:this.data.tradeNo,userId:this.data.userId,userName:this.data.userName}};f["a"].afterSaleRecreate(o).then((function(e){0===e.code&&(t.$toast("提交成功"),t.$utils.storage.set("refreshList",!0),setTimeout((function(){t.$router.go("/serviceList")}),800))})).finally((function(t){}))}}else this.$toast("请选择退款原因");else this.$toast("请选择退货方式");else this.$toast("请选择货物状态")}}},g=p,v=(a("1afe"),Object(c["a"])(g,s,i,!1,null,null,null));e["default"]=v.exports},"5a6d":function(t,e,a){},"673f":function(t,e,a){},a434:function(t,e,a){"use strict";var s=a("23e7"),i=a("23cb"),o=a("a691"),r=a("50c4"),n=a("7b0b"),l=a("65f0"),d=a("8418"),c=a("1dde"),u=c("splice"),h=Math.max,A=Math.min,f=9007199254740991,m="Maximum allowed length exceeded";s({target:"Array",proto:!0,forced:!u},{splice:function(t,e){var a,s,c,u,p,g,v=n(this),y=r(v.length),C=i(t,y),I=arguments.length;if(0===I?a=s=0:1===I?(a=0,s=y-C):(a=I-2,s=A(h(o(e),0),y-C)),y+a-s>f)throw TypeError(m);for(c=l(v,s),u=0;u<s;u++)p=C+u,p in v&&d(c,u,v[p]);if(c.length=s,a<s){for(u=C;u<y-s;u++)p=u+s,g=u+a,p in v?v[g]=v[p]:delete v[g];for(u=y;u>y-s+a;u--)delete v[u-1]}else if(a>s)for(u=y-s;u>C;u--)p=u+s-1,g=u+a-1,p in v?v[g]=v[p]:delete v[g];for(u=0;u<a;u++)v[u+C]=arguments[u+2];return v.length=y-s+a,c}})},c61c:function(t,e,a){"use strict";a("d23a")},d23a:function(t,e,a){},ee87:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAMAAABlApw1AAAAP1BMVEUAAAD4+Pj39/f29vb19fXw8PDx8fHy8vLz8/P09PT19fX29vb39/f4+Pj5+fn6+vr7+/v8/Pz9/f3+/v7///8zJ5QuAAAABXRSTlMAJD2/7XxuZKkAAALNSURBVHja7dtrcqswDAVgEcDGIq4h1v7Xen/caZs2IQW/iqbnrEBfxgcZZkJEXc9K03dERJeBnTWjuhjreLgQdQNPo9JMPHTU651/HCfuid2oOI6JrWaAZWKjGWCYeFQdAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACax1zXGNer0QpwUUREJDqdgPf5UwRnAJiP+UWiUQi4yl2uCgHrPWBVCIj3gAgAjtDfK7H6x+jpFtl0nac0wTmuEl5ExOu9zPn/P6ZvdPyKAzJOwykA9rOPViVgTV9JpwCE+50U9AFm+ZJZG2CKXwFx0gUwN/mWm1EFWOQhiyaAlyfxegAsT8NaAN8L3KrIpQCPBX5dZMOF/r9WChBkM8/22TWKxPlEAC8v4rcW3nwagIuvAA8X0/e+lOhHEYB9Of/DxfSzLwUWXRHAKj9k3epLOAUgyI8Jpb6i1ADMsiPzxsLIrkE+YIp7AB+Dfl8YuTXIBmxvsOeDhj1roiVgkZ1ZHgtQoga5AC+74zcWRt73i0wAy4HwxnnLqkEeYF+BP4u8vDpdvwDYW+APwf7bUhtAkELJqEEOwEuxpH/GywC4WA6Q/hkvHWBLzi/y1hywStlwY0AoPH9qDVIBsxTP2hIwxfKAtBqkAY5usJ2ZmwGWKvMnvd0kAbxUymqaAFiqJbQAVClw8tvNcUClAqfW4DggSNUcfbs5DPBSOaEuwMXagIM1OAiw9ec/+HZzELBKgxyqwTHALE3yVg0Q2gBuAPzyEfL1SrwoL/E4+lvtB+ntzdS9SpwsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADQAGM3zGya2mgGWiZ1mgGPqedI7/8Q9dYNewcRDR3QZ2FmFTTbW8XAhIup6Vpq+I/oHlUqlUPej+ikAAAAASUVORK5CYII="}}]);
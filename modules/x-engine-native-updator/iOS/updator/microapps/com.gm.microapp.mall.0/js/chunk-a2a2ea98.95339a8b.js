(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-a2a2ea98"],{"2af1":function(t,e,s){"use strict";s.r(e);var a=function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("GmHeaderBackImg",{attrs:{scrollCover:!0,backgroundColor:"#f9f9f9","scroll-gradients":!0,gradientsColor:"#f9f9f9"}},[s("div",{attrs:{slot:"header"},slot:"header"},[s("GmHeader",{attrs:{hideItem:["center","right"],leftText:"确认订单","background-color":"transparent"}})],1),s("div",{staticClass:"service-order",attrs:{slot:"main"},slot:"main"},[s("p",{staticClass:"mall-title"},[s("span",{staticClass:"shopImg"}),s("span",{staticClass:"shopName"},[t._v(t._s(t.mallName))])]),t._l(t.orderItemList,(function(e,a){return s("div",{key:a,staticClass:"shop-content"},[s("p",{staticClass:"shop-title"},[t._v(t._s(t.shopName))]),t.showChoose?s("div",{staticClass:"distribution"},[s("span",{staticClass:"title"},[t._v("配送方式")]),s("van-radio-group",{attrs:{direction:"horizontal"},on:{change:t.changeradio},model:{value:t.radio,callback:function(e){t.radio=e},expression:"radio"}},t._l(t.appointTemplates,(function(e,a){return s("van-radio",{key:a,attrs:{name:a,"checked-color":"#FF5F3B","icon-size":"16px"}},[t._v(t._s("SHOP"===e.deliveryType?"到店取送":"上门取送"))])})),1)],1):t._e(),t._l(t.subOrderTemplateList,(function(e,a){return["1"===e.templateComponentType||"2"===e.templateComponentType?s("div",{key:a,staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[e.length?e.length?s("van-field",{attrs:{maxlength:e.length,placeholder:"请输入"},model:{value:t.templateItemValue[t.cuIndex][a],callback:function(e){t.$set(t.templateItemValue[t.cuIndex],a,e)},expression:"templateItemValue[cuIndex][teIndex]"}}):t._e():s("van-field",{attrs:{placeholder:"请输入"},model:{value:t.templateItemValue[t.cuIndex][a],callback:function(e){t.$set(t.templateItemValue[t.cuIndex],a,e)},expression:"templateItemValue[cuIndex][teIndex]"}})],1)]):t._e(),"10"===e.templateComponentType?s("div",{key:a,staticClass:"appointment"},[s("span",{staticClass:"left-title"}),s("span",{staticClass:"right-time"},[s("span",{staticClass:"right-time"},[s("van-radio",{attrs:{name:a,"checked-color":"#FF5F3B","icon-size":"16px"}},[t._v(t._s(e.templateItemValueName))])],1)])]):"5"===e.templateComponentType?s("div",{key:a,staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[s("van-field",{attrs:{type:"digit",maxlength:"11",placeholder:"请输入"},model:{value:t.templateItemValue[t.cuIndex][a],callback:function(e){t.$set(t.templateItemValue[t.cuIndex],a,e)},expression:"templateItemValue[cuIndex][teIndex]"}})],1)]):"6"===e.templateComponentType?s("div",{key:a,staticClass:"appointment",on:{click:function(e){return t.showChooseTime(a)}}},[s("span",{staticClass:"left-title"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"times"},[t._v(t._s(t.templateItemValue[t.cuIndex][a]))]),s("span",{staticClass:"right-icon"})])]):"13"===e.templateComponentType?s("div",{key:a,staticClass:"appointment",on:{click:function(e){return t.selectdop(a)}}},[s("span",{staticClass:"left-title"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"times"},[t._v(t._s(t.templateItemValue[t.cuIndex][a]?t.templateItemValue[t.cuIndex][a]:"请选择自提点"))]),s("span",{staticClass:"right-icon"})])]):"7"===e.templateComponentType?s("div",{key:a,staticClass:"appointment",on:{click:function(e){return t.showChooseTime(a)}}},[s("span",{staticClass:"left-title"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"times"},[t._v(t._s(t.templateItemValue[t.cuIndex][a]))]),s("span",{staticClass:"right-icon"})])]):"14"===e.templateComponentType&&"userAddress"===e.businessCode?s("div",{key:a,staticClass:"address-content",on:{click:t.toSelectAddress}},[s("div",{staticClass:"left-content"},[s("p",[t._v(t._s(t.contactAddress.contacts+" "+t.contactAddress.phone))]),s("p",[t._v(t._s(t.contactAddress.address?t.contactAddress.address:"请选择地址"))])]),s("div",{staticClass:"right-icon"})]):"14"==e.templateComponentType&&"selectShop"===e.businessCode?s("div",{key:a,staticClass:"appointment start"},[s("span",{staticClass:"left-title"},[t._v("店铺地址")]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"times"},[t._v(t._s(t.templateItemValue[t.cuIndex][a]))])])]):"14"==e.templateComponentType&&"startingAddress"===e.businessCode||"14"==e.templateComponentType&&"endAddress"===e.businessCode?s("div",{key:a,staticClass:"appointment"},[s("span",{staticClass:"left-title dark"},[t._v(t._s(e.templateItemValueName))]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"times",on:{click:function(e){return t.showAreaList(a)}}},[t._v(t._s(t.templateItemValue[t.cuIndex][a]?t.templateItemValue[t.cuIndex][a]:"选择省/市/区"))]),s("span",{staticClass:"right-icon"})])]):t._e()]})),s("div",{staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v("留言")]),s("span",{staticClass:"right-time"},[s("van-field",{attrs:{placeholder:"选填，请先与商家协商一致"},model:{value:t.remark,callback:function(e){t.remark=e},expression:"remark"}})],1)]),t.noActivityCart.length>0?s("van-card",{staticClass:"card",attrs:{desc:t.descFormat(t.noActivityCart[0]),title:t.noActivityCart.length>0&&t.noActivityCart[0].skuName,thumb:t.noActivityCart.length>0&&t.noActivityCart[0].mainPicUrl,price:t.noActivityCart.length>0&&t.noActivityCart[0].salePrice.toFixed(2),num:t.noActivityCart.length>0&&t.noActivityCart[0].number}}):t._e(),t.specDyncJson?s("ul",{staticClass:"card-list"},t._l(t.specDyncJson,(function(e,a){return s("li",{key:a},[s("span",{staticClass:"card-list-title"},[t._v(t._s(e.specName))]),s("span",{staticClass:"card-list-price"},[s("span",{staticClass:"price"},[t._v("¥"+t._s(e.salePrice.toFixed(2)))]),s("span",{staticClass:"num"},[t._v("x "+t._s(t.noActivityCart.length>0?e.number*t.noActivityCart[0].number:""))])])])})),0):t._e(),t.noActivityCart.length>1?s("p",{staticClass:"charge-title"},[t._v("收费清单")]):t._e(),t.noActivityCart.length>1?s("ul",{staticClass:"charge-list"},[t._l(t.noActivityCart,(function(e,a){return[a>0&&e.number>0?s("li",{key:a},[s("div",{staticClass:"left-content"},[s("p",[t._v(t._s(e.skuName))]),s("p",[t._v(t._s(e.skuSpecValues))])]),s("div",{staticClass:"right-content"},[s("p",[t._v("¥"+t._s(e.price.toFixed(2)))]),s("p",[t._v("x "+t._s(e.number))])])]):t._e()]}))],2):t._e(),"DEPOSIT"!==t.payType?s("div",{staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v("店铺优惠")]),t.canUseCoupon?t._e():s("span",{staticClass:"right-time"},[s("span",{staticClass:"text"},[t._v("无优惠券可用")])]),t.canUseCoupon?s("span",{staticClass:"right-time",on:{click:t.showCoupon}},[s("span",{staticClass:"text"},[t._v(t._s(t.couponItem.couTypeTitle))]),s("span",{staticClass:"right-icon"})]):t._e()]):t._e(),"DEPOSIT"!==t.payType?s("div",{staticClass:"divider"}):t._e(),"DEPOSIT"!==t.payType?s("div",{staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v("商品总额")]),s("span",{staticClass:"right-time"},[s("span",{staticClass:"shop-address"},[t._v("¥"+t._s(t.orderItemList&&t.orderItemList.length>0?t.orderItemList[0].amount:""))])])]):t._e(),s("div",{staticClass:"line"}),"DEPOSIT"===t.payType?s("div",{staticClass:"all-price-content"},[s("span",[t._v("共1件")]),s("span",[t._v("小计：")]),s("span",[t._v("¥"+t._s(t.orderItemList&&t.orderItemList.length>0?(t.orderItemList[0].payAmount+t.orderItemList[0].depositAmount).toFixed(2):""))])]):t._e(),"DEPOSIT"===t.payType?s("div",{staticClass:"all-price-content"},[s("span"),s("span",[t._v("（含定金：¥"+t._s(t.orderItemList&&t.orderItemList.length>0?t.orderItemList[0].depositAmount:"")+"）")])]):t._e(),"DEPOSIT"!==t.payType?s("div",{staticClass:"all-price-content"},[s("span"),s("span",[t._v("需付款：")]),s("span",[t._v("¥"+t._s(t.orderItemList&&t.orderItemList.length>0?t.orderItemList[0].payAmount:""))])]):t._e()],2)})),"DEPOSIT"!==t.payType?s("div",{staticClass:"usecoupon shop-content"},[s("div",{staticClass:"appointment"},[s("span",{staticClass:"left-title"},[t._v("平台优惠券")]),t.canUseCouponPLATF?t._e():s("span",{staticClass:"right-time"},[s("span",{staticClass:"text"},[t._v("无优惠券可用")])]),t.canUseCouponPLATF?s("span",{staticClass:"right-time",on:{click:t.showCouponPlatef}},[s("span",{staticClass:"text"},[t._v(t._s(t.couponPLATFItem.couTypeTitle))]),s("span",{staticClass:"right-icon"})]):t._e()])]):t._e(),"DEPOSIT"!==t.payType?[s("integral",{attrs:{minUseAmount:t.allIntegral(t.orderItemList,"minUseAmount"),payDigital:t.payDigital,payAmount:Number(t.allPayAmount(t.orderItemList)),allNum:t.allIntegral(t.orderItemList,"userBalanceDigital"),deductionState:t.allIntegral(t.orderItemList,"deductionState"),step:t.allIntegral(t.orderItemList,"unitDeductionStep")}},[s("div",{staticClass:"rights-content"},[s("span",{staticClass:"title-left"},[t._v("共"+t._s(t.allIntegral(t.orderItemList,"userBalanceDigital"))+"可用")]),s("van-stepper",{attrs:{"input-width":"10px","button-size":"20px",step:t.allIntegral(t.orderItemList,"unitDeductionStep"),"disable-input":"",option:t.option,min:0,max:t.allIntegral(t.orderItemList,"userCanUseDigital")},on:{change:t.changestep},model:{value:t.payDigital,callback:function(e){t.payDigital=e},expression:"payDigital"}})],1)])]:t._e(),s("div",{staticClass:"bottom-btn-content",style:{height:t.bottomHeight}},[s("div",{staticClass:"container"},[s("div",{staticClass:"left-content"},["DEPOSIT"!==t.payType?s("p",[t._v("¥"+t._s(t.allPayAmount(t.orderItemList)))]):t._e(),"DEPOSIT"===t.payType?s("p",[t._v("¥"+t._s(t.orderItemList&&t.orderItemList.length>0?t.orderItemList[0].depositAmount:""))]):t._e(),"DEPOSIT"===t.payType?s("p",[t._v("服务完成后支付尾款")]):t._e()]),s("van-button",{staticClass:"submit-btn",attrs:{type:"primary"},on:{click:t.submitConfim}},[t._v(t._s("DEPOSIT"===t.payType?"支付定金":"提交订单"))])],1)]),s("TimePop",{ref:"timePops",attrs:{minDate:t.minDate,maxDate:t.maxDate,dateType:t.datetime,hasFilter:t.hasFilter,option:t.option},on:{subTimePicker:t.subTimePicker,cancelTimePicker:t.cancelTimePicker,setShowTimePop:t.setShowTimePop}}),s("van-popup",{attrs:{round:"",position:"bottom"},model:{value:t.show,callback:function(e){t.show=e},expression:"show"}},[s("van-area",{attrs:{title:"选择省市区","area-list":t.areaList,"columns-placeholder":["请选择","请选择","请选择"]},on:{cancel:function(e){t.show=!1},confirm:t.onConfirm}})],1),s("van-popup",{style:{height:"70%"},attrs:{round:"",position:"bottom"},model:{value:t.showselctShop,callback:function(e){t.showselctShop=e},expression:"showselctShop"}},[s("div",{staticClass:"shopztd"},[s("van-radio-group",{model:{value:t.radioshop,callback:function(e){t.radioshop=e},expression:"radioshop"}},t._l(t.selectdopList,(function(e,a){return s("div",{key:a,staticClass:"shopbox"},[s("p",{staticClass:"name"},[s("van-radio",{staticStyle:{width:"100%"},attrs:{name:e.id},on:{click:function(s){return t.clickshop(e)}}},[t._v(t._s(e.name))])],1),s("div",{staticClass:"info"},[s("p",{staticClass:"iscs"},[t._v(t._s(e.address))]),s("p",{staticClass:"iscs"},[s("span",[t._v(" "+t._s(e.linkman)+" ")]),s("span",{staticStyle:{"margin-left":"8px"}},[t._v(" "+t._s(e.phone)+" ")])]),s("p",{staticClass:"comment"},[t._v("备注内容："+t._s(e.remark))])])])})),0)],1)]),s("ShowDialog",{ref:"showDialog",attrs:{showDialog:t.showDialog,dataArr:t.dataArr,type:t.type},on:{cancelConfim:t.cancelConfim,confirmBtn:t.confirmBtn,setshowDialog:t.setshowDialog}})],2)])},i=[],o=(s("4160"),s("159b"),s("a15b"),s("b680"),s("b64b"),s("e25e"),s("c1df")),n=s.n(o),r=s("3419"),c=s("94ee"),l=s("42a1"),d={name:"ServiceOrder",components:{TimePop:r["a"],integral:c["a"],ShowDialog:l["a"]},data:function(){return{couNo:["-1","-1"],canUseCoupon:!1,canUseCouponPLATF:!1,dataArr:[],couponItem:{couTypeTitle:"不使用优惠",couNo:"-1"},couponPLATFItem:{couTypeTitle:"不使用优惠",couNo:"-1"},userCanUseCoupon:[],userCanUseCouponPLATF:[],showDialog:!1,selectAddress:"",isMiniprogram:this.$utils.isMiniprogram(),unitId:this.$route.query.unitId,hasFilter:!0,option:1,type:"",acctType:"",payDigital:0,dateData:{},shopAddress:"无",showChoose:!1,show:!1,areaList:{},cityIndex:"",contactAddress:{addrId:"",id:0,address:"",contacts:"",phone:"",defaultAddr:0},remark:"",showselctShop:!1,radioshop:"",clickShopIndex:"",selectdopList:[],addressbmIndex:[],cuIndex:0,subOrderTemplateList:[],appointTemplates:[],templateItemValue:[],noActivityCart:[],specDyncJson:"",mallName:"",shopName:"",goodsType:this.$route.query.goodsType,deliveryType:this.$route.query.deliverType,mallCode:this.$route.query.mallCode,shopCode:this.$route.query.shopCode,skuCode:this.$route.query.skuCode,payType:"",orderItemList:[],addDesc:[],addTime:[],contacts:[],contactNumber:[],moveOutAddress:[],moveInAddress:[],detailedAddress:[],datetime:"datetime",data:"",radio:0,clickIndex:"",addressIndex:"",addressType:"",showChangeTime:!1,showPicker2:!1,time:"1982-12-22",value:"",currentDate:new Date,maxDate:new Date((new Date).getFullYear()+1,0,1),minDate:new Date}},created:function(){this.$utils.isMiniprogram()&&this.$route.query.userToken&&(this.$utils.storage.set("userToken",this.$route.query.userToken),this.$utils.storage.set("sessionToken",this.$route.query.sessionToken),this.$utils.storage.set("GMJUserInfo",this.$route.query.userInfo)),this.toast(),this.visibilityEve(),this.getArea(),this.getInfo()},computed:{bottomHeight:function(){return this.$tabbarHeight+"px"}},methods:{toast:function(){this.$toast.loading({duration:0,type:"loading",message:"加载中...",forbidClick:!0})},descFormat:function(t){var e=t.skuSpecValues;if(t.skuSpecJson)try{var s=JSON.parse(t.skuSpecJson),a=[];s.forEach((function(t){a.push(t.featureName+": "+t.featureValue)})),e=a.join("  ")}catch(i){console.error(i)}return e},showCouponPlatef:function(){this.type="PLATF",this.dataArr=this.userCanUseCouponPLATF,this.$refs.showDialog.radio=this.couNo[1],this.$refs.showDialog.showDialog=!0,this.$refs.showDialog.type="PLATF"},showCoupon:function(){this.type="coupon",this.dataArr=this.userCanUseCoupon,this.$refs.showDialog.radio=this.couNo[0],this.$refs.showDialog.showDialog=!0,this.$refs.showDialog.type="coupon"},cancelConfim:function(){this.$refs.showDialog.showDialog=!1},confirmBtn:function(t){"coupon"===this.type?(this.couponItem=t,this.couNo[0]=t.couNo):(this.couponPLATFItem=t,this.couNo[1]=t.couNo),this.$refs.showDialog.showDialog=!1,this.toast(),this.getServiceDetail(!0)},setshowDialog:function(t){this.showDialog=t},allPayAmount:function(t){var e=0;return t&&t.length>0&&t[0].payAmount&&(e=t[0].payAmount),this.$decimal(e).toFixed(2)},allIntegral:function(t,e){var s=0;if(Object.keys(t).length>0)try{s=t[0]?t[0].digitalList[0][e]:""}catch(a){window.e=a}return s},payDigitalMax:function(t){var e=this.allIntegral(t,"minUseAmount");return this.allPayAmountVal<e&&this.payDigital>0?this.payDigital:this.allIntegral(t,"userCanUseDigital")},changestep:function(){this.toast(),this.getServiceDetail(!0)},clickshop:function(t){this.showselctShop=!1,this.templateItemValue[this.cuIndex][this.clickShopIndex]=t.name},getInfo:function(){var t=this,e={code:this.$route.query.shopCode};this.$api.getStoreInfo(e).then((function(e){0===e.code&&e.data.shopInfo.shopAddress&&(t.shopAddress=e.data.shopInfo.shopAddress),t.getAddressDefault()})).catch((function(){t.getAddressDefault()}))},selectdop:function(t){var e=this;this.clickShopIndex=t;var s={id:this.data.ouOccur[0].store[0].merId};this.$api.getPointlistById(s).then((function(t){0===t.code?t.data.merchantPointRelList.length>0?(e.selectdopList=t.data.merchantPointRelList,e.showselctShop=!0):(e.selectdopList=[],e.showselctShop=!1,e.$toast("该商户未配置自提点")):e.$toast(t.message)}))},visibilityEve:function(){var t=this;t.$utils.visibilityEve((function(){var e=t.$utils.storage.get("selectaddress");if(e){var s=JSON.parse(e),a=s.provinceName,i=s.cityName,o=s.countyName,n=s.detail,r=s.userName,c=s.phone,l=s.addrId,d=s.remark,p=void 0===d?"":d;t.contactAddress.address=a+i+o+n+p,t.contactAddress.contacts=r,t.contactAddress.phone=c,t.contactAddress.addrId=l,t.contactAddress.defaultAddr=s.defaultAddr,t.$utils.storage.set("selectaddress","");var u={};u.mobile=t.contactAddress.phone,u.userName=t.contactAddress.contacts,u.address=t.contactAddress.address,u.addressId=t.contactAddress.addrId,t.templateItemValue[t.cuIndex][t.addressbmIndex[t.cuIndex]]=JSON.stringify(u)}}))},setInteFun:function(){var t=this;this.timer=setInterval((function(){if(t.$utils.storage.get("selectaddress")&&t.selectAddress!==t.$utils.storage.get("selectaddress")){var e=t.$utils.storage.get("selectaddress");if(e){var s=JSON.parse(e),a=s.provinceName,i=s.cityName,o=s.countyName,n=s.detail,r=s.userName,c=s.phone,l=s.addrId,d=s.remark,p=void 0===d?"":d;t.contactAddress.address=a+i+o+n+p,t.contactAddress.contacts=r,t.contactAddress.phone=c,t.contactAddress.addrId=l,t.contactAddress.defaultAddr=s.defaultAddr,t.$utils.storage.set("selectaddress","");var u={};u.mobile=t.contactAddress.phone,u.userName=t.contactAddress.contacts,u.address=t.contactAddress.address,u.addressId=t.contactAddress.addrId,t.templateItemValue[t.cuIndex][t.addressbmIndex[t.cuIndex]]=JSON.stringify(u)}clearInterval(t.timer)}t.selectAddress=t.$utils.storage.get("selectaddress")}),1e3)},toSelectAddress:function(){this.$utils.isMiniprogram()?(this.setInteFun(),window.wx.miniProgram.navigateTo({url:"/pages/h5Webview/h5Webview?webviewUrl="+encodeURIComponent("/shoppingAddress?addrId="+this.contactAddress.addrId+"&defaultAddr="+this.contactAddress.defaultAddr+"&type=1")})):this.$router.push({path:"/shoppingAddress",query:{addrId:this.contactAddress.addrId,defaultAddr:this.contactAddress.defaultAddr,type:"1"}})},getTemplateList:function(){var t={modelType:this.appointTemplates[this.cuIndex].templateType,shopId:this.shopCode,templateId:this.appointTemplates[this.cuIndex].templateCode},e=this;e.$api.getTemplateDateList(t).then((function(t){if(0===t.code){e.dateData=t.data,e.option=t.data[0].startTimeLimitValue,3===t.data[0].timeType?e.datetime="date":2===t.data[0].timeType?e.datetime="year-month":4===t.data[0].timeType?e.datetime="datehour":5===t.data[0].timeType&&(e.datetime="datetime");var s=new Date;s.setDate(s.getDate()+(t.data[0].currentDateLimitValue-1)),e.maxDate=new Date(s.getFullYear()+"/"+(s.getMonth()+1)+"/"+s.getDate()+" "+t.data[0].endTime),e.minDate=new Date((new Date).toLocaleDateString()+" "+t.data[0].todayStartTime),e.currentDate=new Date((new Date).toLocaleDateString()+" "+t.data[0].todayStartTime)}}))},getArea:function(){var t=this;this.$api.apiUtil.getAreaTree().then((function(e){e.codeList&&(t.areaList=e.codeList)}))},onConfirm:function(t){for(var e="",s=[],a=0;a<t.length;a++)s.push(t[a].name);e=s.join("/"),this.templateItemValue[this.cuIndex][this.cityIndex]=e,this.show=!1},getAddressDefault:function(){var t=this,e={pageNum:0,pageSize:999,userId:this.$utils.getUserId()};e.userId&&this.$api.shoppingAdress(e).then((function(e){if(e&&0===e.code){var s=null;if(e.data.userAddressResultList&&e.data.userAddressResultList.forEach((function(t){1===t.defaultAddr&&(s=t)})),e.data.userAddressResultList&&(s||(s=e.data.userAddressResultList[0])),s){var a=s,i=a.provinceName,o=a.cityName,n=a.countyName,r=a.detail,c=a.userName,l=a.phone,d=a.addrId,p=a.remark,u=void 0===p?"":p;t.contactAddress.address=i+o+n+r+u,t.contactAddress.contacts=c,t.contactAddress.phone=l,t.contactAddress.addrId=d,t.contactAddress.defaultAddr=1,t.getServiceDetail()}else t.getServiceDetail()}}))},getServiceDetail:function(t){for(var e=this,s=[],a=0;a<this.couNo.length;a++)"-1"!==this.couNo[a]&&s.push(this.couNo[a]);var i={carts:JSON.parse(this.$route.query.carts),mallCode:this.mallCode,cityCode:this.$cityCode,deliveryType:this.deliveryType,cartType:"SERVICE",couNo:s,payDigital:[{acctType:this.acctType,payDigital:this.payDigital}]},o=this;o.$api.getServiceOrderData(i).then((function(s){if(0===s.code){if(o.$toast.clear(),s.data.ouOccur&&s.data.ouOccur[0].depositAmount>0&&(o.payType="DEPOSIT"),o.data=s.data,s.data.appointTemplates){"NORMAL"!==s.data.appointTemplates[o.cuIndex].deliveryType&&(o.showChoose=!0);for(var a=0;a<s.data.appointTemplates.length;a++){o.templateItemValue.push([]),o.addressbmIndex.push("");for(var i=0;i<s.data.appointTemplates[a].subOrderTemplateList.length;i++)if("14"===s.data.appointTemplates[a].subOrderTemplateList[i].templateComponentType&&"userAddress"===s.data.appointTemplates[a].subOrderTemplateList[i].businessCode)if(o.addressbmIndex[a]=i,o.contactAddress.address){var n={};n.mobile=e.contactAddress.phone,n.userName=e.contactAddress.contacts,n.address=e.contactAddress.address,n.addressId=e.contactAddress.addrId,o.templateItemValue[a][i]=JSON.stringify(n)}else o.templateItemValue[a][i]="";else"13"===s.data.appointTemplates[a].subOrderTemplateList[i].templateComponentType?o.templateItemValue[a][i]="":"14"===s.data.appointTemplates[a].subOrderTemplateList[i].templateComponentType&&"selectShop"===s.data.appointTemplates[a].subOrderTemplateList[i].businessCode&&(o.templateItemValue[a][i]=o.shopAddress)}o.subOrderTemplateList=s.data.appointTemplates[o.cuIndex].subOrderTemplateList,o.appointTemplates=s.data.appointTemplates}if(o.orderItemList=s.data.ouOccur,s.data.ouOccur){t&&(o.payDigital=s.data.ouOccur[0].digitalList[0].payDigital),o.acctType=s.data.ouOccur[0].digitalList[0]&&s.data.ouOccur[0].digitalList[0].acctType,o.noActivityCart=s.data.ouOccur[0].store[0].noActivityCart;for(var r=0;r<o.noActivityCart.length;r++)o.allNum+=o.noActivityCart[r].number;if(o.userCanUseCoupon=[],o.userCanUseCouponPLATF=[],s.data.ouOccur[0].userCanUseCoupon){for(var c=0;c<s.data.ouOccur[0].userCanUseCoupon.length;c++)"SHOP"===s.data.ouOccur[0].userCanUseCoupon[c].couCategory?o.userCanUseCoupon.push(s.data.ouOccur[0].userCanUseCoupon[c]):o.userCanUseCouponPLATF.push(s.data.ouOccur[0].userCanUseCoupon[c]);"-1"===o.couponItem.couNo&&(o.couponItem.couTypeTitle=o.userCanUseCoupon.length+"张优惠券可用"),"-1"===o.couponPLATFItem.couNo&&(o.couponPLATFItem.couTypeTitle=o.userCanUseCouponPLATF.length+"张优惠券可用"),o.userCanUseCoupon.length<1?o.canUseCoupon=!1:o.canUseCoupon=!0,o.userCanUseCouponPLATF.length<1?o.canUseCouponPLATF=!1:o.canUseCouponPLATF=!0}}s.data.ouOccur[0].store[0].noActivityCart[0].specDyncJson&&(o.specDyncJson=JSON.parse(s.data.ouOccur[0].store[0].noActivityCart[0].specDyncJson)),o.mallName=s.data.ouOccur?s.data.ouOccur[0].mallName:"",o.shopName=s.data.ouOccur?o.$shopAliasName(s.data.ouOccur[0].store[0]):"",o.getTemplateList()}})).catch((function(){}))},changeradio:function(t){var e=parseInt(t);this.cuIndex=e,this.subOrderTemplateList=this.appointTemplates[e].subOrderTemplateList},showChooseTime:function(t){this.clickIndex=t,this.$refs.timePops.currentDate=this.currentDate,this.$refs.timePops.showChangeTime=!0},setShowTimePop:function(t){this.showChangeTime=t},cancelTimePicker:function(){this.$refs.timePops.showChangeTime=!1},setCurrent:function(){this.$refs.timePops.setDefault(this.currentDate)},subTimePicker:function(t){this.showChangeTime=!1,"date"===this.datetime?this.templateItemValue[this.cuIndex][this.clickIndex]=n()(t).format("YYYY-MM-DD"):"datetime"===this.datetime?this.templateItemValue[this.cuIndex][this.clickIndex]=n()(t).format("YYYY-MM-DD HH:mm"):"year-month"===this.datetime?this.templateItemValue[this.cuIndex][this.clickIndex]=n()(t).format("YYYY-MM"):"datehour"===this.datetime&&(this.templateItemValue[this.cuIndex][this.clickIndex]=n()(t).format("YYYY-MM-DD HH")),this.$forceUpdate()},adder:function(t){this.showPicker2=t},showAreaList:function(t){this.show=!0,this.cityIndex=t},showAreaInList:function(t){this.show=!0,this.cityIndex=t},submitConfim:function(){this.toast();for(var t=[],e=0;e<this.couNo.length;e++)"-1"!==this.couNo[e]&&t.push(this.couNo[e]);if(this.templateItemValue.length>0)for(var s=0;s<this.templateItemValue[this.cuIndex].length;s++)if(this.appointTemplates[this.cuIndex].subOrderTemplateList[s].templateItemValue=this.templateItemValue[this.cuIndex][s],"5"===this.appointTemplates[this.cuIndex].subOrderTemplateList[s].templateComponentType&&!this.$utils.isTruePhone("86",this.templateItemValue[this.cuIndex][s]))return void this.$toast("请输入正确手机号");var a={carts:JSON.parse(this.$route.query.carts),remark:[{remark:this.remark,shopCode:this.shopCode}],payDigital:[{acctType:this.acctType,payDigital:this.payDigital}],couNo:t,cityCode:this.$cityCode,mallCode:this.mallCode,deliveryType:this.deliveryType,appointTemplate:this.appointTemplates[this.cuIndex]},i=this;i.$api.submitOrderService(a).then((function(t){if(0===t.code){var e=t.data;i.$utils.pay.gmPay(e,"service",!0),i.$toast.clear()}})).catch((function(){}))}}},p=d,u=(s("5f77"),s("2877")),m=Object(u["a"])(p,a,i,!1,null,null,null);e["default"]=m.exports},3419:function(t,e,s){"use strict";var a=function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("van-dialog",{staticClass:"time-pop",attrs:{"show-cancel-button":""},model:{value:t.showChangeTime,callback:function(e){t.showChangeTime=e},expression:"showChangeTime"}},[s("div",{staticClass:"change-time"},[s("div",{staticClass:"title"},[t._v(t._s(t.titleName))]),s("van-datetime-picker",{attrs:{type:t.dateType,"item-height":"40","visible-item-count":"5",filter:t.filter,hasFilter:t.hasFilter,"min-date":t.minDate,"max-date":t.maxDate,formatter:t.formatter},on:{confirm:t.subTimePicker,cancel:t.cancelTimePicker},model:{value:t.currentDate,callback:function(e){t.currentDate=e},expression:"currentDate"}})],1)])},i=[],o=(s("a9e3"),s("4de4"),s("c1df")),n=s.n(o),r={name:"TimePop",props:{dateType:{type:String,default:""},minDate:{type:Date,default:new Date},maxDate:{type:Date,default:new Date},titleName:{type:String,default:"选择时间"},hasFilter:{type:Boolean,default:!1},option:{type:Number,default:1}},components:{},data:function(){return{showChangeTime:!1,currentDate:""}},watch:{showChangeTime:function(t){this.$emit("setShowTimePop",t)}},methods:{moment:n.a,filter:function(t,e){var s=this,a=e[0]%this.option;return this.hasFilter&&"minute"===t?e.filter((function(t){return t%s.option===a})):e},formatter:function(t,e){return"month"===t?"".concat(e,"月"):"day"===t?"".concat(e,"日"):"hour"===t?"".concat(e,"时"):"minute"===t?"".concat(e,"分"):e},setDefault:function(t){this.currentDate=t},subTimePicker:function(t){this.showChangeTime=!1,"datetime"===this.dateType?this.currentDate=new Date(n()(t).format("YYYY/MM/DD HH:mm:ss")):"date"===this.dateType?this.currentDate=new Date(n()(t).format("YYYY/MM/DD")):"year-month"===this.dateType?this.currentDate=new Date(n()(t).format("YYYY/MM")):"datehour"===this.dateType?this.currentDate=new Date(n()(t).format("YYYY/MM/DD HH")):this.currentDate=new Date(n()(t).format("YYYY/MM/DD")),this.$emit("subTimePicker",this.currentDate)},cancelTimePicker:function(){this.showChangeTime=!1,this.$emit("cancelTimePicker")}}},c=r,l=(s("e716"),s("2877")),d=Object(l["a"])(c,a,i,!1,null,null,null);e["a"]=d.exports},5492:function(t,e,s){},"5de4":function(t,e,s){},"5f77":function(t,e,s){"use strict";s("5de4")},c20d:function(t,e,s){var a=s("da84"),i=s("58a8").trim,o=s("5899"),n=a.parseInt,r=/^[+-]?0[Xx]/,c=8!==n(o+"08")||22!==n(o+"0x16");t.exports=c?function(t,e){var s=i(String(t));return n(s,e>>>0||(r.test(s)?16:10))}:n},e25e:function(t,e,s){var a=s("23e7"),i=s("c20d");a({global:!0,forced:parseInt!=i},{parseInt:i})},e716:function(t,e,s){"use strict";s("5492")}}]);
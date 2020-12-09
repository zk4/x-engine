//命名空间 
const moduleID = "com.zkty.module.yjzdbill";

// 支付dto
interface YJBillDTO {
  //会员标识
  businessCstNo: string;
  //预下单平台商户号
  platMerCstNo: string;
  //预下单交易商户号
  tradeMerCstNo: string;
  //业务系统订单号
  billNo:string;
  //当前app注册的appScheme
  appScheme:string;
  //支付业务， 是否是 B端调用，  true为B， false为C
  payType:boolean;
}
// 退款dto
interface YJBillRefundDTO {
  //退款订单编号
  refundOrderNo:string;
}

//返回状态dto
interface YJBillRetDTO {
  //返回状态
  billRetStatus: string;
  //状态信息
  billRetStatusMessage:string
}

//账单中心dto
interface YJBillListDTO {
  //会员标识
  businessCstNo: string;
  //当前app注册的appScheme
  appScheme:string;
  //支付业务， 是否是 B端调用，  true为B， false为C
  payType:boolean;
}

//支付
function YJBillPayment(
  args: YJBillDTO = {
    appScheme:'x-engine',
    payType:false
  }
):YJBillRetDTO {
  window.YJBillPayment = () => {
    yjzdbill
      .YJBillPayment({
    businessCstNo:"000001",
    platMerCstNo: "8377631273379692750",
    tradeMerCstNo: "8377707718294634760",
    billNo:'01202012081346103822413721356429',
    appScheme:'x-engine',
    payType:false,
        __ret__:(res)=>{
                  console.log(JSON.stringify(res));
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        }
      })
  };
}

//退款
function YJBillRefund(
  args: YJBillRefundDTO 
):YJBillRetDTO {
  window.YJBillRefund = () => {
    yjzdbill
      .YJBillRefund({
        refundOrderNo:'RFO1607064781790',
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

//账单中心
function YJBillList(
  args: YJBillListDTO){
  window.YJBillList = () => {
    yjzdbill
      .YJBillList({
    businessCstNo:"000001",
    appScheme:'x-engine',
    payType:false

      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

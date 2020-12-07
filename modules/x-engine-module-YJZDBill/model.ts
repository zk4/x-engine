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
interface ContinousDTO {
  __event__:(string)=>{}
}
function echo(args:ContinousDTO):string{
  window.echo = () => {
    yjzdbill
      .echo({
          __ret__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify("__ret__"+res);
          },
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
      //.then((res) => {
        //document.getElementById("debug_text").innerText = JSON.stringify(res);
      //});
  };
}

//支付
function YJBillPayment(
  YJBillDTO: YJBillDTO = {
    businessCstNo:"000001",
    platMerCstNo: "8377631273379692750",
    tradeMerCstNo: "8377707718294634760",
    billNo:'022020120416543228724452ba399222',
    appScheme:'zdsdk',
    payType:false
  }
):YJBillRetDTO {
  window.YJBillPayment = () => {
    yjzdbill
      .YJBillPayment({
        __ret__:(res)=>{
                  console.log(JSON.stringify(res));
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        }
      })
  };
}

//退款
function YJBillRefund(
  YJBillRefundDTO: YJBillRefundDTO = {
    refundOrderNo:'RFO1607064781790',
    __event__:(string)=>{}
  }
):YJBillRetDTO {
  window.YJBillRefund = () => {
    yjzdbill
      .YJBillRefund({
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
  YJBillListDTO: YJBillListDTO = {
    businessCstNo:"000001",
    appScheme:'zdsdk',
    payType:false
  }
){
  window.YJBillList = () => {
    yjzdbill
      .YJBillList()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

// 命名空间
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
  appScheme?:string;
  //支付业务， 是否是 B端调用，  true为B， false为C
  payType?:boolean;
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
  //房屋编号
  roomNo:string;
  //人防编号
  userRoomNo:string;
  //当前app注册的appScheme
  appScheme?:string;
  //支付业务， 是否是 B端调用，  true为B， false为C
  payType?:boolean;
  // 账单状态（取值为：0-全部  10-待支付  90-已完成）
  billStatus?:string;
  //账单类型取值为：0-全部 1-物业收费账单,2-月保续费账单,3-停车费账单,4-临时收费账单,5-零售,6-预缴费,7-旅游,8-家政,9-拎包，10-押金
  billType?:string;
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
    businessCstNo:"13631095145",
    platMerCstNo: "1253152026819723265",
    tradeMerCstNo: "1253159474293014528",
    billNo:"022020121511175711404131412404",
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
        refundOrderNo:'RFO16070658578',
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
  args: YJBillListDTO={
    appScheme:'x-engine',
    payType:false
  }){
  window.YJBillList = () => {
    yjzdbill
      .YJBillList({
    businessCstNo:"000001",
    roomNo:'001',
    userRoomNo:'001',
    billStatus:'90',
    billType:'0'
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

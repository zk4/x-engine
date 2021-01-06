
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-yjzdbill
```



## YJBillPayment

支付

**demo**
``` js
 {
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string | 必填 |  | 会员标识 |
| platMerCstNo | string | 必填 |  | 预下单平台商户号 |
| tradeMerCstNo | string | 必填 |  | 预下单交易商户号 |
| billNo | string | 必填 |  | 业务系统订单号 |
| appScheme | string | optional | x-engine | 当前app注册的appScheme |
| payType | bool | optional |  | 支付业务， 是否是 B端调用，  true为B， false为C |

**返回值**
**无参数**




## YJBillRefund

退款

**demo**
``` js
 {
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string | 必填 |  | 退款订单编号 |

**返回值**
**无参数**




## YJBillList

账单中心

**demo**
``` js
{
  window.YJBillList = () => {
    yjzdbill
      .YJBillList({
    businessCstNo:"000001",
    roomNo:'001',
    userRoomNo:'001'
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string | 必填 |  | 会员标识 |
| roomNo | string | 必填 |  | 房屋编号 |
| userRoomNo | string | 必填 |  | 人防编号 |
| appScheme | string | optional | x-engine | 当前app注册的appScheme |
| payType | bool | 必填 |  | 支付业务， 是否是 B端调用，  true为B， false为C |
| billStatus | string | 必填 | 0 |  账单状态（取值为：0-全部  10-待支付  90-已完成） |
| billType | string | 必填 | 0 | 账单类型取值为：0-全部 1-物业收费账单,2-月保续费账单,3-停车费账单,4-临时收费账单,5-零售,6-预缴费,7-旅游,8-家政,9-拎包，10-押金 |

**返回值**
**无参数**



    
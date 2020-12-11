
version: 0.0.59
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  |  | 会员标识 |
| platMerCstNo | string |  |  | 预下单平台商户号 |
| tradeMerCstNo | string |  |  | 预下单交易商户号 |
| billNo | string |  |  | 业务系统订单号 |
| appScheme | string |  | x-engine | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |


## YJBillRefund

退款

**demo**
``` js
 {
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string |  |  | 退款订单编号 |


## YJBillList

账单中心

**demo**
``` js
{
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  |  | 会员标识 |
| appScheme | string |  |  | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |

    
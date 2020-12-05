
version: 0.0.10
``` bash
npm install @zkty-team/x-engine-module-yjzdbill
```



## echo



**demo**
``` js
{
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  |  |  |


## YJBillPayment

支付

**demo**
``` js
 {
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  | 000001 | 会员标识 |
| platMerCstNo | string |  | 8377631273379692750 | 预下单平台商户号 |
| tradeMerCstNo | string |  | 8377707718294634760 | 预下单交易商户号 |
| billNo | string |  | 022020120416543228724452ba399222 | 业务系统订单号 |
| appScheme | string |  | zdsdk | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |


## YJBillRefund

退款

**demo**
``` js
 {
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
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string |  | RFO1607064781790 | 退款订单编号 |


## YJBillList

账单中心

**demo**
``` js
{
  window.YJBillList = () => {
    yjzdbill
      .YJBillList()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  | 000001 | 会员标识 |
| appScheme | string |  | zdsdk | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |

    
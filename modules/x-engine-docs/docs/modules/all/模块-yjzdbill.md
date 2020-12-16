

**基座扫描测试**
<div id='modulename' style='display:none'>yjzdbill</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.0.67
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
| businessCstNo | string |  |  | 会员标识 |
| platMerCstNo | string |  |  | 预下单平台商户号 |
| tradeMerCstNo | string |  |  | 预下单交易商户号 |
| billNo | string |  |  | 业务系统订单号 |
| appScheme | string | true | x-engine | 当前app注册的appScheme |
| payType | bool | true |  | 支付业务， 是否是 B端调用，  true为B， false为C |


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
| businessCstNo | string |  |  | 会员标识 |
| roomNo | string |  |  | 房屋编号 |
| userRoomNo | string |  |  | 人防编号 |
| appScheme | string | true | x-engine | 当前app注册的appScheme |
| payType | bool | true |  | 支付业务， 是否是 B端调用，  true为B， false为C |

    

# iOS


# android



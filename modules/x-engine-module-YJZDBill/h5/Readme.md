
`
com.zkty.module.YJZDBill
`



## YJBillPayment

支付

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  | 000001 | 会员标识 |
| platMerCstNo | string |  | 8377631273379692750 | 预下单平台商户号 |
| tradeMerCstNo | string |  | 8377707718294634760 | 预下单交易商户号 |
| billNo | string |  | 022020120416543228724452ba399222 | 业务系统订单号 |
| appScheme | string |  | zdsdk | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |
| \_\_event\_\_ |  |  | (string)=>{} |  当前支付状态回调函数 |


## YJBillRefund

退款

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string |  | RFO1607064781790 | 退款订单编号 |
| \_\_event\_\_ |  |  | (string)=>{} |  当前退款状态回调函数 |


## YJBillList

账单中心

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  | 000001 | 会员标识 |
| appScheme | string |  | zdsdk | 当前app注册的appScheme |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |

    
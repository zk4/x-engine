
`
com.zkty.module.yjzdbill
`



## YJBillPayment

支付

	
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

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string |  |  | 退款订单编号 |


## YJBillList

账单中心

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  |  | 会员标识 |
| roomNo | string |  |  | 房屋编号 |
| userRoomNo | string |  |  | 人防编号 |
| appScheme | string | true | x-engine | 当前app注册的appScheme |
| payType | bool | true |  | 支付业务， 是否是 B端调用，  true为B， false为C |
| billStatus | string | true |  |  账单状态  0  10  90 |
| billType | string | true |  | 账单类型 0 1 2 3 4 |

    
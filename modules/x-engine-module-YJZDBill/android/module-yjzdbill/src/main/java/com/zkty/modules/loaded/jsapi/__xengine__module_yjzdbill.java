package com.zkty.modules.loaded.jsapi;


import androidx.annotation.Nullable;

import com.kapp.sdllpay.PaymentCallback;
import com.yjlc.module.BillManager;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.XEngineApplication;

import org.json.JSONException;
import org.json.JSONObject;


public class __xengine__module_yjzdbill extends xengine__module_yjzdbill {

    @Override
    public void _echo(ContinousDTO dto, CompletionHandler<String> handler) {

    }

    @Override
    public void _YJBillPayment(YJBillDTO dto, CompletionHandler<YJBillRetDTO> handler) {

        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineApplication.getApplication());
        billManager.payBills("", dto.billNo, dto.businessCstNo, dto.platMerCstNo, dto.tradeMerCstNo, dto.payType ? com.yjlc.module.constant.AppConstant.payType_2b : com.yjlc.module.constant.AppConstant.payType_2c, new BillManager.BillPaymentCallBack() {
            @Override
            public void payRsult(JSONObject jsonObject) {

                if (jsonObject.has("status")) {
                    YJBillRetDTO yjBillRetDTO = new YJBillRetDTO();
                    try {
                        yjBillRetDTO.billRetStatus = jsonObject.getString("status");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    handler.complete(yjBillRetDTO);

                }

            }
        });


    }

    @Override
    public void _YJBillRefund(YJBillRefundDTO dto, CompletionHandler<YJBillRetDTO> handler) {

        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineApplication.getApplication());
        billManager.refundBills(dto.refundOrderNo, new PaymentCallback() {
            @Override
            public void paymentResult(JSONObject jsonObject) {
                if (jsonObject.has("status")) {
                    YJBillRetDTO yjBillRetDTO = new YJBillRetDTO();
                    try {
                        yjBillRetDTO.billRetStatus = jsonObject.getString("status");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    handler.complete(yjBillRetDTO);

                }

            }
        });


    }

    @Override
    public void _YJBillList(YJBillListDTO dto, CompletionHandler<Nullable> handler) {

        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineApplication.getApplication());
        billManager.queryBills(dto.businessCstNo, "", "", dto.payType ? com.yjlc.module.constant.AppConstant.payType_2b : com.yjlc.module.constant.AppConstant.payType_2c);
        handler.complete();
    }
}

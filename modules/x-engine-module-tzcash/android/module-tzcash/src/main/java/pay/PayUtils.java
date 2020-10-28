package pay;

import android.content.Context;
import android.util.Log;

import com.google.gson.Gson;
import com.rrtx.tzpaylib.CashierManager;
import com.rrtx.tzpaylib.PaymentCallback;

public class PayUtils {
    private static final String TAG = PayUtils.class.getSimpleName();


    public interface PayResultListener {
        public void onPayResultListener(String result);
    }

    /**
     * 调起支付
     *
     * @param orderFlowNo   订单号
     * @param businessCstNo 客户号
     * @param platMerCstNo  商户号
     * @param frontBackUrl  前端回调地址
     */
    public static void Pay(Context context, String orderFlowNo, String businessCstNo, String platMerCstNo, String frontBackUrl, final PayResultListener listener) {
        CashierManager.getInstance().init(context);                //云闪付初始化

        Gson gson = new Gson();
        PayBean payBean = new PayBean();

        payBean.setOrderFlowNo(orderFlowNo);
        payBean.setBusinessCstNo(businessCstNo);
        payBean.setPlatMerCstNo(platMerCstNo);
        payBean.setFrontBackUrl(frontBackUrl);

//        payBean.setOrderFlowNo("8449812917599076394");     //订单号
//        payBean.setBusinessCstNo("15374649080");   //客户号
//        payBean.setPlatMerCstNo("8377631273379692750");    //商户号
//        payBean.setFrontBackUrl("http://124.193.110.228:9191/shopDemo/merNotifyBack");    //前端回调地址

        String json = gson.toJson(payBean);

        CashierManager.getInstance().launchPayment(json, new PaymentCallback() {
            @Override
            public void paymentResult(String orderStatus) {//orderStatus:当前订单的状态 10 初始状态，70 失败，80关闭  90成功
                Log.d(TAG, "paymentResult:" + orderStatus);
                if (listener != null) {
                    listener.onPayResultListener(orderStatus);
                }
            }
        });
    }
}

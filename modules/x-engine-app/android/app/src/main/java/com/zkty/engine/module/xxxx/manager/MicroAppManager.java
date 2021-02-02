package com.zkty.engine.module.xxxx.manager;


import android.content.Context;
import android.net.Network;
import android.text.TextUtils;
import android.util.Base64;

import com.zkty.engine.module.xxxx.dto.MicroAppInfoBean;
import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.engine.module.xxxx.network.callback.ServiceCallback;
import com.zkty.engine.module.xxxx.network.networkframe.bean.BaseResp;
import com.zkty.engine.module.xxxx.network.networkframe.net.exception.ApiException;
import com.zkty.engine.module.xxxx.network.service.CommonService;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.utils.MD5Utils;
import com.zkty.modules.engine.utils.MD5withRSA;
import com.zkty.modules.engine.utils.ToastUtils;
import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;
import com.zkty.modules.loaded.imp.XEngineNetImpl;
import com.zkty.modules.loaded.jsapi.RouterMaster;
import com.zkty.modules.loaded.jsapi.WgtManager;
import com.zkty.modules.loaded.widget.dialog.DialogHelper;

import java.io.InputStream;

public class MicroAppManager {
    private static final String TAG = MicroAppManager.class.getSimpleName();

    private static final String PUBLIC_KEY = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAOStm75rop0nrz1rQzfEsJISlbgLUPHM" +
            "rG02vYwcW8ZJ2H5eGVBsMJBM52DiyPHrWeKO8hTLtGBPzS3lbREOci8CAwEAAQ==";


    private static MicroAppManager configStorage;
    private Context mContext;

    public static MicroAppManager getInstance() {
        if (configStorage == null) {
            configStorage = new MicroAppManager();
        }
        return configStorage;
    }

    private MicroAppManager() {
        mContext = XEngineApplication.getApplication();
    }

    public void updateMicroApp() {
        String microAppId = "917d2f38aa104fe98bbc72dc976a6df8";
        NetworkMaster.getInstance().getCommonService().getMicroAppListById(microAppId, new ServiceCallback<BaseResp<MicroAppInfoBean>>() {
            @Override
            public void onSuccess(BaseResp<MicroAppInfoBean> jsonObj) {

                MicroAppInfoBean microAppInfoBean = jsonObj.getData();
                if (microAppInfoBean != null && microAppInfoBean.getMicroapps() != null
                        && microAppInfoBean.getMicroapps().size() > 0) {
                    MicroAppInfoBean.MicroappsBean microappsBean = microAppInfoBean.getMicroapps().get(0);
                    downloadAndCheck(microappsBean);
                }

            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });


    }

    private void downloadAndCheck(MicroAppInfoBean.MicroappsBean microappsBean) {

        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        ixEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, CommonService.getInstance().MICRO_SERVE + microappsBean.getUrl(), null, null, null, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                InputStream inputStream = response.getBody();
                if (inputStream != null) {
//                    String pathTemp = MicroAppsManager.getInstance().saveApp(inputStream, microappsBean.getMicroAppId(), String.valueOf(microappsBean.getVersion()));
//                    if (!TextUtils.isEmpty(pathTemp)) {
//                        checkApp(microappsBean.getSignature(), pathTemp);
//                    }

                    checkApp(microappsBean.getSignature(), inputStream);
                }
                DialogHelper.hideDialog();
                ToastUtils.showThreadToast("资源加载失败，请重试");
            }

            @Override
            public void onUploadProgress(XEngineNetRequest xEngineNetRequest, long l, long l1, boolean b) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest xEngineNetRequest, XEngineNetResponse
                    xEngineNetResponse, long l, long l1, boolean b) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DialogHelper.hideDialog();
                ToastUtils.showThreadToast("资源加载失败，请重试");
            }
        });


    }

    /**
     * 校验app
     * 1,下载的zip包用md5加密，得到md5值，
     * 2，signature 用公钥解密得到服务端zip 的md5值
     * 3，对比结果
     *
     * @param signature
     * @param inputStream
     */
    private boolean checkApp(String signature, InputStream inputStream) {

        String md5 = MD5Utils.calculateMD5(inputStream);

        return MD5withRSA.verifySign(md5, PUBLIC_KEY, signature);

    }

}

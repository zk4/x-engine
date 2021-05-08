package com.zkty.nativ.device;

import android.content.Intent;
import android.net.Uri;

import com.alibaba.fastjson.JSON;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.core.utils.DeviceUtils;

import java.util.HashMap;
import java.util.Map;

import module.device.R;

public class NativeDevice extends NativeModule implements IDevice {

    @Override
    public String moduleId() {
        return "com.zkty.native.device";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public String getStatusBarHeight() {
        return String.valueOf((int)DensityUtils.pixelsToDip(XEngineApplication.getApplication(), DensityUtils.getStatusBarHeight(XEngineApplication.getApplication())));
    }

    @Override
    public String getNavigationHeight() {
        return String.valueOf((int)DensityUtils.pixelsToDip(XEngineApplication.getApplication(),XEngineApplication.getApplication().getResources().getDimension(R.dimen.dp_65)));
    }

    @Override
    public String getScreenHeight() {
        return String.valueOf((int)DensityUtils.pixelsToDip(XEngineApplication.getApplication(),DensityUtils.getScreenHeight(XEngineApplication.getApplication())));
    }

    @Override
    public String getTabbarHeight() {
        return String.valueOf((int)DensityUtils.pixelsToDip(XEngineApplication.getApplication(),XEngineApplication.getApplication().getResources().getDimension(R.dimen.dp_70)));
    }

    @Override
    public String getSystemVersion() {
        return DeviceUtils.getSystemVersion();
    }

    @Override
    public String getUDID() {
        return null;
    }

    @Override
    public String callPhone(String phone) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        Uri data = Uri.parse("tel:" + phone);
        intent.setData(data);
        XEngineApplication.getCurrentActivity().startActivity(intent);
        return null;
    }

    @Override
    public String sendMessage(String phone, String msg) {
        Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:" + phone));
        intent.putExtra("sms_body", msg);
        XEngineApplication.getCurrentActivity().startActivity(intent);
        return null;
    }

    @Override
    public String getDeviceInfo() {
        Map<String, String> map = new HashMap<>();
        map.put("type", "android");
        map.put("systemVersion", DeviceUtils.getSystemVersion());
        map.put("language", DeviceUtils.getSystemLanguage());

        return JSON.toJSONString(map);
    }
}

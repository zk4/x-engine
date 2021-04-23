package com.zkty.jsi;

import android.webkit.JavascriptInterface;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.DeviceUtils;
import com.zkty.nativ.device.IDevice;
import com.zkty.nativ.device.NativeDevice;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

import java.util.HashMap;
import java.util.Map;

public class JSIOldDeviceModule extends JSIModule {

    private NativeDevice iDevice;

    @Override
    public String moduleId() {
        return "com.zkty.module.device";
    }

    @Override
    protected void afterAllJSIModuleInited() {

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDevice.class);
        if (module instanceof NativeDevice)
            iDevice = (NativeDevice) module;
    }

    @JavascriptInterface
    public void getStatusHeight(JSONObject obj, final CompletionHandler<Object> handler) {
        Map<String, Object> map = new HashMap<>();
        if (iDevice != null) {
            map.put("content", iDevice.getStatusBarHeight());
        }
        handler.complete(map);

    }
  @JavascriptInterface
    public void getSystemVersion(JSONObject obj, final CompletionHandler<Object> handler) {
        Map<String, Object> map = new HashMap<>();
        if (iDevice != null) {
            map.put("content", iDevice.getSystemVersion());
        }
        handler.complete(map);

    }
 @JavascriptInterface
    public void getPhoneType(JSONObject obj, final CompletionHandler<Object> handler) {
        Map<String, Object> map = new HashMap<>();
        if (iDevice != null) {
            map.put("content", "ANDROID");
        }
        handler.complete(map);

    }

    @JavascriptInterface
    public void getTabBarHeight(JSONObject obj, final CompletionHandler<Object> handler) {
        Map<String, Object> map = new HashMap<>();
        if (iDevice != null) {
            map.put("content", iDevice.getTabbarHeight());
        }
        handler.complete(map);

    }

    @JavascriptInterface
    public void devicePhoneCall(JSONObject obj, final CompletionHandler<Object> handler) {
        if (iDevice != null) {
            iDevice.callPhone(obj.getString("phoneNumber"));
            handler.complete();
        }

    }

    @JavascriptInterface
    public void deviceSendMessage(JSONObject obj, final CompletionHandler<Object> handler) {
        if (iDevice != null) {
            iDevice.sendMessage(obj.getString("phoneNumber"), obj.getString("messageContent"));
            handler.complete();
        }
    }
   
}

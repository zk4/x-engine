package com.zkty.jsi;

import com.alibaba.fastjson.JSON;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.device.IDevice;
import com.zkty.nativ.device.NativeDevice;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_device extends xengine_jsi_device {


    private NativeDevice iDevice;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDevice.class);
        if (module instanceof NativeDevice)
            iDevice = (NativeDevice) module;

    }

    @Override
    public String _getStatusBarHeight() {
        return iDevice.getStatusBarHeight();
    }

    @Override
    public String _getNavigationHeight() {
        return iDevice.getNavigationHeight();
    }

    @Override
    public String _getScreenHeight() {
        return iDevice.getScreenHeight();
    }

    @Override
    public String _getTabbarHeight() {
        return iDevice.getTabbarHeight();
    }


    @Override
    public String _callPhone(phoneDto dto) {
        return iDevice.callPhone(dto.phoneNum);
    }

    @Override
    public String _sendMessage(phoneDto dto) {
        return iDevice.sendMessage(dto.phoneNum, dto.phoneMsg);
    }


    @Override
    public void _getDeviceInfo(CompletionHandler<DeviceDTO> handler) {
        String json = iDevice.getDeviceInfo();
        handler.complete(JSON.parseObject(json, DeviceDTO.class));
    }


}

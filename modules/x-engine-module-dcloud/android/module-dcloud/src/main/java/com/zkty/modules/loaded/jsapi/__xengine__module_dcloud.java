package com.zkty.modules.loaded.jsapi;


import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.core.IApplicationListener;
import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.engine.utils.FileUtils;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.MenuActionSheetItem;


public class __xengine__module_dcloud extends xengine__module_dcloud implements IApplicationListener {

    @Override
    public void onAppCreate(Context context) {
        UniMPMaster.initialize(context);
    }

    @Override
    public void onAppLowMemory() {

    }

    @Override
    public void _openUniMP(DcloudDTO dto, CompletionHandler<Nullable> handler) {
        UniMPMaster.startUniApp(dto.appId, null, null);
    }
    

    @Override
    public void _preloadUniMP(UniMPDTO dto, CompletionHandler<Nullable> handler) {
        UniMPMaster.preload(dto.appId);
    }

    @Override
    public void _openUniMPWithArg(UniMPDTO dto, CompletionHandler<Nullable> handler) {
        UniMPMaster.startUniApp(dto.appId, dto.redirectPath, dto.arguments);
    }
}

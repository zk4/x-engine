package com.zkty.modules.jsapi.jsapi;

import android.content.Context;
import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.modules.engine.core.IApplicationListener;

import java.io.File;

public class __xengine__module_engine extends xengine__module_engine implements IApplicationListener {
    @Override
    public void onAppCreate(Context context) {
        String dir = new File("/data/data/" + context.getPackageName() + "/shared_prefs").getAbsolutePath() + "/mmkv";
        String rootDir = MMKV.initialize(dir);
        Log.d("onAppCreate", "mmkv init root: " + rootDir);
    }

    @Override
    public void onAppLowMemory() {

    }


}

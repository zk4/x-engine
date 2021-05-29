package com.zkty.nativ.store;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class NativeStore extends NativeModule implements IStore {

    @Override
    public String moduleId() {
        return "com.zkty.native.store";
    }

    @Override
    public void afterAllNativeModuleInited() {
        super.afterAllNativeModuleInited();
        String dir = new File("/data/data/" + XEngineApplication.getApplication().getPackageName() + "/shared_prefs").getAbsolutePath() + "/mmkv";
        String rootDir = MMKV.initialize(dir);
        Log.d("onAppCreate", "mmkv init root: " + rootDir);
    }

    @Override
    public Object get(String key) {
        return StoreUtils.get(key, null);
    }

    @Override
    public void set(String key, Object value) {
        StoreUtils.put(key, value);
    }

    @Override
    public boolean has(String key) {
        return StoreUtils.contains(key);
    }

    @Override
    public void del(String key) {
        StoreUtils.remove(key);
    }

    @Override
    public void saveTodisk() {

    }

    @Override
    public void loadFromDisk(boolean merge) {

    }
}

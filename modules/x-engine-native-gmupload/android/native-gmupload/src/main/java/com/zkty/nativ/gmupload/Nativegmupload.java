package com.zkty.nativ.gmupload;

import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import org.json.JSONException;

import java.io.File;
import java.util.HashMap;

public class Nativegmupload extends NativeModule implements Igmupload {

    @Override
    public String moduleId() {
        return "com.zkty.native.gmupload";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }


    @Override
    public void doUploadFile(String url, String filePath, OnUploadListener fileUploadObserver) {
        UploadUtils.doUploadFile(url, filePath, new OnUploadListener() {
            @Override
            public void onUploadSuccess(String dataStr) {
                if(fileUploadObserver == null)return;
                fileUploadObserver.onUploadSuccess(dataStr);
            }
            @Override
            public void onUploading(int progress) {
                Log.d("Nativemedia",progress + "%");
                fileUploadObserver.onUploading(progress);
            }

            @Override
            public void onUploadFailed() {
                if(fileUploadObserver == null)return;
                fileUploadObserver.onUploadFailed();
            }
        });
    }
}

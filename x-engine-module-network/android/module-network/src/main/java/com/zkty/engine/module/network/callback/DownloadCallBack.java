package com.zkty.engine.module.network.callback;

import android.util.Log;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Response;

public interface DownloadCallBack {
    public void onFailure(Call call, IOException e);

    public void onResponse(Call call, Response response, String filepath);

}

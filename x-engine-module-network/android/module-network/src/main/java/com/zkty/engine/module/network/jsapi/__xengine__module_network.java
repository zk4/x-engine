package com.zkty.engine.module.network.jsapi;

import android.util.Log;
import android.webkit.JavascriptInterface;

import com.zkty.engine.module.network.callback.DownloadCallBack;
import com.zkty.engine.module.network.net.OkHttpManager;
import com.zkty.modules.dsbridge.CompletionHandler;

import org.jetbrains.annotations.NotNull;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Response;

public class __xengine__module_network {

    private static final String MODULE_ID = "com.zkty.module.network";

    public __xengine__module_network() {
    }

    @JavascriptInterface
    public void request(JSONObject obj, final CompletionHandler<String> handler) {
        try {

            if ("GET".equalsIgnoreCase(obj.getString("method"))) {

                OkHttpManager.getInstance().asyncGet(obj.getString("url"), new Callback() {
                    @Override
                    public void onFailure(@NotNull Call call, @NotNull IOException e) {
                        handler.complete(e.getMessage());

                    }

                    @Override
                    public void onResponse(@NotNull Call call, @NotNull Response response) throws IOException {
                        handler.complete(response.body().string());
                    }
                });

            } else if ("POST".equalsIgnoreCase(obj.getString("method"))) {
                OkHttpManager.getInstance().asyncPost(obj.getString("url"), obj.getString("params"), new Callback() {
                    @Override
                    public void onFailure(@NotNull Call call, @NotNull IOException e) {
                        handler.complete(e.getMessage());
                    }

                    @Override
                    public void onResponse(@NotNull Call call, @NotNull Response response) throws IOException {
                        handler.complete(response.body().string());
                    }
                });

            }


        } catch (Exception e) {
            e.printStackTrace();
        }


        Log.d("JsApi", "request = " + obj.toString());
    }

    @JavascriptInterface
    public void download(JSONObject obj, final CompletionHandler<String> handler) {

        try {

            OkHttpManager.getInstance().download(obj.getString("url"), new DownloadCallBack() {
                @Override
                public void onFailure(@NotNull Call call, @NotNull IOException e) {
                    handler.complete(e.getMessage());

                }

                @Override
                public void onResponse(@NotNull Call call, @NotNull Response response, String filePath) {
                    JSONObject object = new JSONObject();
                    try {
                        object.put("filePath", filePath);
                        handler.complete(object.toString());
                    } catch (JSONException e) {
                        e.printStackTrace();
                        handler.complete(e.getMessage());
                    }

                }
            });


        } catch (Exception e) {
            e.printStackTrace();
        }

        Log.d("JsApi", "request = " + obj.toString());
    }


//    @JavascriptInterface
//    public void syncCalendar(Object msg, CompletionHandler<Integer> handler) {
//        try {
//            JSONObject obj = new JSONObject(msg.toString());
//            String id = obj.getString("id");
//            String title = obj.getString("title");
//            long deadline = obj.getLong("deadline");
//            JSONArray earlyRemindTime = obj.getJSONArray("alarm");
//            String res = CalendarReminderUtils.addCalendarEvent(id, title, deadline, earlyRemindTime);
//            handler.complete(Integer.valueOf(res));
//        } catch (Exception e) {
//            e.printStackTrace();
//            handler.complete(6005);
//        }
//    }
}


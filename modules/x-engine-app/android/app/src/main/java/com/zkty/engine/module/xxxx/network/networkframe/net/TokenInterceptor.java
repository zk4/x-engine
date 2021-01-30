package com.zkty.engine.module.xxxx.network.networkframe.net;

import android.app.Activity;
import android.content.Intent;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.zkty.engine.module.xxxx.network.ConfigStorage;
import com.zkty.engine.module.xxxx.network.Constants;
import com.zkty.engine.module.xxxx.network.networkframe.bean.BaseResp;
import com.zkty.engine.module.xxxx.network.networkframe.bean.TokenBean;
import com.zkty.engine.module.xxxx.network.service.CommonService;
import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.engine.utils.ToastUtils;

import java.io.IOException;
import java.nio.charset.Charset;

import okhttp3.FormBody;
import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okio.Buffer;
import okio.BufferedSource;

import static com.alibaba.fastjson.util.IOUtils.UTF8;

public class TokenInterceptor implements Interceptor {
    @Override
    public Response intercept(Chain chain) throws IOException {
        Request request = chain.request()
                .newBuilder()
                .header("Authorization", ConfigStorage.getInstance().getTokenBean().getTokenHead() + ConfigStorage.getInstance().getTokenBean().getToken())
                .removeHeader("User-Agent")
                .addHeader("User-Agent", getUserAgent())
                .build();
        ;
        Response response = chain.proceed(request);

        //根据和服务端的约定判断token过期
        if (isTokenExpired(response)) {
            //同步请求方式，获取最新的Token
            getNewToken();
            //使用新的Token，创建新的请求
            Request newRequest = chain.request()
                    .newBuilder()
                    .header("Authorization", ConfigStorage.getInstance().getTokenBean().getTokenHead() + ConfigStorage.getInstance().getTokenBean().getToken())
                    .removeHeader("User-Agent")
                    .addHeader("User-Agent", getUserAgent())
                    .build();
            //重新请求
            return chain.proceed(newRequest);
        }
        return response;


    }

    private void getNewToken() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(CommonService.getInstance().HOST_OAUTH).append("token")
                .append("?")
                .append("grant_type=refresh_token").append("&")
                .append("scope=").append(Constants.SCOPE).append("&")
                .append("client_id=").append(Constants.CLIENT_ID).append("&")
                .append("client_secret=").append(Constants.CLIENT_SECRET).append("&")
                .append("refresh_token=").append(ConfigStorage.getInstance().getTokenBean().getRefreshToken());
        OkHttpClient client = new OkHttpClient();
        FormBody.Builder builder = new FormBody.Builder();
        Request request = new Request.Builder().post(builder.build()).url(stringBuilder.toString()).build();
        okhttp3.Call call = client.newCall(request);
        try {
            Response response = call.execute();
            BaseResp<TokenBean> data = JSON.parseObject(response.body().string(), new TypeReference<BaseResp<TokenBean>>() {
            });
            if (data.getCode() == 200 && data.getData() != null) {
                ConfigStorage.getInstance().saveTokenInfo(data.getData());
            } else {
                startActivity();
            }

        } catch (IOException e) {
            e.printStackTrace();
            startActivity();
        }
    }

    private void startActivity() {
        ConfigStorage.getInstance().clearTokenInfo();
        Activity activity = ActivityUtils.getCurrentActivity();
        if (activity == null) return;
        activity.runOnUiThread(() -> {
            ToastUtils.showCenterToast("登录信息过期，请重新登录");
//            try {
//                Class login = Class.forName("LoginActivity");
//                Intent intent = new Intent(activity, login);
//                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                activity.startActivity(intent);
//
//            } catch (ClassNotFoundException e) {
//                e.printStackTrace();
//            }
        });
//


    }

    private boolean isTokenExpired(Response response) {
        try {
            if (response.isSuccessful()) {
                ResponseBody responseBody = response.body();
                BufferedSource source = responseBody.source();
                source.request(Long.MAX_VALUE);
                Buffer buffer = source.buffer();
                Charset charset = UTF8;
                MediaType contentType = responseBody.contentType();
                if (contentType != null) {
                    charset = contentType.charset(UTF8);
                }
                String bodyString = buffer.clone().readString(charset);
                BaseResp httpResult = JSON.parseObject(bodyString, BaseResp.class);
                return httpResult.getCode() == 401;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;

    }

    private String getUserAgent() {
        String userAgent;
        userAgent = System.getProperty("http.agent");
        StringBuilder sb = new StringBuilder();
        for (int i = 0, length = userAgent.length(); i < length; i++) {
            char c = userAgent.charAt(i);
            if (c <= '\u001f' || c >= '\u007f') {
                sb.append(String.format("\\u%04x", (int) c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }


}

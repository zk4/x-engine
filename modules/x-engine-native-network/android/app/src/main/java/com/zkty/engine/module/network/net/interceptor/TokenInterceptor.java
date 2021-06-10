package com.zkty.engine.module.network.net.interceptor;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.bean.BaseResp;

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
                .header("Authorization", "Bearer 123465" )
                .removeHeader("User-Agent")
                .addHeader("User-Agent", getUserAgent())
                .build();
        ;
        Response response = chain.proceed(request);

        //根据和服务端的约定判断token过期
//        if (isTokenExpired(response)) {
//            //同步请求方式，获取最新的Token
//            getNewToken();
//            //使用新的Token，创建新的请求
//            Request newRequest = chain.request()
//                    .newBuilder()
//                    .header("Authorization", "Bearer " )
//                    .removeHeader("User-Agent")
//                    .addHeader("User-Agent", getUserAgent())
//                    .build();
//            //重新请求
//            return chain.proceed(newRequest);
//        }
        return response;

    }

    private void getNewToken() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("http://10.115.91.71:32383/login/").append("renewToken");
        OkHttpClient client = new OkHttpClient();
        FormBody.Builder builder = new FormBody.Builder();
        Request request = new Request.Builder()
                .header("Authorization", "Bearer " )
                .post(builder.build())
                .url(stringBuilder.toString())
                .build();
        okhttp3.Call call = client.newCall(request);

        try {
            Response response = call.execute();
            BaseResp data = JSON.parseObject(response.body().string(), new TypeReference<BaseResp>() {
            });
            if (data.getCode() ==0 && data.getData() != null) {
//                ConfigStorage.getInstance().saveUserBean(data.getData());
            } else {
                startActivity();
            }

        } catch (IOException e) {
            e.printStackTrace();
            startActivity();
        }
    }

    private void startActivity() {
//        ConfigStorage.getInstance().clearUserBean();
//        Activity activity = XEngineApplication.getCurrentActivity();
//        if (activity == null) return;
//        activity.runOnUiThread(() -> {
//            ConfigStorage.getInstance().clearLoginResult();
//            ConfigStorage.getInstance().clearUserSCN();
//            ConfigStorage.getInstance().clearUserBean();
//            ConfigStorage.getInstance().clearIMTokenBean();
//            EventBus.getDefault().post(new XEngineMessage(XEngineMessage.MSG_TYPE_LOGIN, ""));
//
//        });
////


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
                return httpResult.getCode() == 10001;
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

package com.zkty.nativ.network.net.converter;

import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.utils.GsonUtil;

import java.io.IOException;

import okhttp3.ResponseBody;
import retrofit2.Converter;


public class StringResponseBodyConverter implements Converter<ResponseBody, String> {

    /**
     * 构造器
     */
    public StringResponseBodyConverter() {
    }

    @Override
    public String convert(ResponseBody responseBody) throws IOException {
        String response = responseBody.string();
//        BaseResp baseModel = GsonUtil.fromJson(response,BaseResp.class);
        return  response;
    }
}

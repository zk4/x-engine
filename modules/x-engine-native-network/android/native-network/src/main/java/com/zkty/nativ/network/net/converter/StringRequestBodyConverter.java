package com.zkty.nativ.network.net.converter;


import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.RequestBody;
import retrofit2.Converter;

public class StringRequestBodyConverter<T> implements Converter<T, RequestBody> {
    private static final MediaType MEDIA_TYPE = MediaType.parse("application/json; charset=UTF-8");


    StringRequestBodyConverter() {
    }

    @Override
    public RequestBody convert(T value) throws IOException {
        // 加密
//        Log.wtf(Constant.logTag, "加密前的数据：" + value.toString());
        return RequestBody.create(MEDIA_TYPE, value.toString());
    }
}

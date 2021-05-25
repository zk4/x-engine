package com.zkty.nativ.network.net.converter;

import android.text.TextUtils;

import com.google.gson.TypeAdapter;
import com.zkty.nativ.network.utils.LogUtils;

import java.io.IOException;

import okhttp3.ResponseBody;
import retrofit2.Converter;


public class DecodeResponseBodyConverter<T> implements Converter<ResponseBody, T> {
    private final TypeAdapter<T> adapter;

    DecodeResponseBodyConverter(TypeAdapter<T> adapter) {
        this.adapter = adapter;
    }

    @Override
    public T convert(ResponseBody value) throws IOException {
        if (value != null && value.contentType() != null) {
            LogUtils.d(value.contentType().toString());
        }

        byte[] bytes = value.bytes();
        //先解密 在解压
//        try {
//            bytes=  GzipUtil.unZip(new TripleDES(Contacts.BODY_ENCRYPTION_KEY).decryptionByteData(bytes));
//        } catch (Exception e) {
//            e.printStackTrace();
//
//        }

        //解密字符串
        return TextUtils.isEmpty(new String(bytes, "UTF-8")) ? null : adapter.fromJson(new String(bytes, "UTF-8"));
    }
}
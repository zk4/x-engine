package com.zkty.nativ.network.api;


import java.util.Map;

import okhttp3.MultipartBody;
import retrofit2.http.Part;
import rx.Observable;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.HeaderMap;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.PartMap;
import retrofit2.http.QueryMap;
import retrofit2.http.Streaming;
import retrofit2.http.Url;

public interface RetrofitHttpService {
    @GET()
    Call<String> get(@Url String url, @QueryMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @FormUrlEncoded
    @POST()
    Call<String> post(@Url String url, @FieldMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @POST()
    Call<String> post(@Url String url, @Body String data, @HeaderMap Map<String, String> headers);

    @GET()
    Observable<String> Obget(@Url String url, @QueryMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @FormUrlEncoded
    @POST()
    Observable<String> ObpostMap(@Url String url, @FieldMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @POST()
    Observable<String> ObpostBody(@Url String url, @Body Map<String, String> params, @HeaderMap Map<String, String> headers);

    @POST()
    Observable<String> ObpostQuery(@Url String url, @QueryMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @POST()
    Observable<String> ObpostPath(@Url String url, @HeaderMap Map<String, String> headers);

    @FormUrlEncoded
    @PUT
    Observable<String> Obput(@Url String url, @FieldMap Map<String, String> params, @HeaderMap Map<String, String> headers);

    @Streaming
    @GET()
    Observable<ResponseBody> Obdownload(@HeaderMap Map<String, String> headers, @Url String url, @QueryMap Map<String, String> params);
    @GET()
    Observable<ResponseBody> Obdownload(@HeaderMap Map<String, String> headers, @Url String url, @Body String data);
    @GET()
    Observable<ResponseBody> Obdownload(@HeaderMap Map<String, String> headers, @Url String url);
    @Streaming
    @GET()
    Call<ResponseBody> download(@HeaderMap Map<String, String> headers, @Url String url, @QueryMap Map<String, String> params);
    @GET()
    Call<ResponseBody> download(@HeaderMap Map<String, String> headers, @Url String url, @Body String data);
    @Multipart
    @POST()
    Call<String> uploadMultipleTypeFile(@Url String url, @FieldMap Map<String, String> params, @HeaderMap Map<String, String> headers, @PartMap Map<String, RequestBody> Filesparams);
    @Multipart
    @POST()
    Call<String> uploadMultipleTypeFile(@Url String url, @Body String data, @HeaderMap Map<String, String> headers, @PartMap Map<String, RequestBody> Filesparams);
    @Multipart
    @POST
    Observable<ResponseBody> uploadMultipleTypeFile(@Url String url, @Part MultipartBody.Part file);
}

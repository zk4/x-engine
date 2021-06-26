package com.zkty.nativ.geo_gaode;

import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.geo.IGeoManager;
import com.zkty.nativ.geo.Igeo;

import java.util.HashMap;
import java.util.Map;

public class Nativegeo_gaode extends NativeModule implements Igeo {

    private AMapLocationClient mLocationClient = null;
    private AMapLocationListener mLocationListener = null;
    private IGeoManager.CallBack mCallback;

    @Override
    public String moduleId() {
        return "com.zkty.native.geo_gaode";
    }

    @Override
    public void afterAllNativeModuleInited() {
        //初始化定位
        mLocationClient = new AMapLocationClient(XEngineApplication.getApplication().getApplicationContext());
        mLocationListener = new AMapLocationListener() {
            @Override
            public void onLocationChanged(AMapLocation amapLocation) {
                if (amapLocation != null) {
                    if (amapLocation.getErrorCode() == 0) {
                        //可在其中解析amapLocation获取相应内容。
                        Map<String, String> result = new HashMap<>();
                        result.put("longitude", String.valueOf(amapLocation.getLongitude()));
                        result.put("latitude", String.valueOf(amapLocation.getLatitude()));
                        result.put("address", amapLocation.getAddress());
                        result.put("country", amapLocation.getCountry());
                        result.put("province", amapLocation.getProvince());
                        result.put("city", amapLocation.getCity());
                        result.put("district", amapLocation.getDistrict());
                        result.put("street", amapLocation.getStreet());
                        if (mCallback != null) {
                            mCallback.onLocation(JSON.toJSONString(result));
                        }
                        mLocationClient.stopLocation();
                        return;

                    } else {
                        //定位失败时，可通过ErrCode（错误码）信息来确定失败的原因，errInfo是错误信息，详见错误码表。
                        Log.e("AmapError", "location Error, ErrCode:"
                                + amapLocation.getErrorCode() + ", errInfo:"
                                + amapLocation.getErrorInfo());

                    }
                }
                if (mCallback != null) {
                    mCallback.onLocation(null);
                }
                mLocationClient.stopLocation();
            }
        };
        //设置定位回调监听
        mLocationClient.setLocationListener(mLocationListener);

    }

    @Override
    public void locate(IGeoManager.CallBack callBack) {
        AMapLocationClientOption option = new AMapLocationClientOption();
//        option.setLocationPurpose(AMapLocationClientOption.AMapLocationPurpose.SignIn);
        option.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy)//高精度定位模式：会同时使用网络定位和GPS定位，优先返回最高精度的定位结果，以及对应的地址描述信息。
                .setOnceLocationLatest(true)//获取最近3s内精度最高的一次定位结果：
                .setNeedAddress(true)//设置定位同时是否需要返回地址描述。
                .setMockEnable(false)//设置是否允许模拟软件Mock位置结果，多为模拟GPS定位结果
                .setLocationCacheEnable(true);//开启缓存机制

        if (null != mLocationClient) {
            mLocationClient.setLocationOption(option);
            mCallback = callBack;
            //设置场景模式后最好调用一次stop，再调用start以保证场景模式生效
            mLocationClient.stopLocation();
            mLocationClient.startLocation();
        } else {
            callBack.onLocation(null);
        }

    }
}

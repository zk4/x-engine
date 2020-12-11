package com.zkty.modules.loaded.jsapi;


import android.util.Log;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baidu.location.BDLocation;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.XEngineApplication;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class __xengine__module_geo extends xengine__module_geo {
	private static final String TAG = "XEngine__module_geo";
	private GeoEventDTO geoEventDTO;
	private  LocationBean locationBean;
	private String strCoorType;

	@Override
	public void _coordinate(GeoReqDTO dto, CompletionHandler<GeoResDTO> handler) {


	}

	@Override
	public void _locate(GeoEventDTO dto, CompletionHandler<Nullable> handler) {
		if(dto != null){
			strCoorType = dto.type;
		}else{
			strCoorType="BMK09LL";
		}
		LocationManager.getLocation(XEngineApplication.getApplication(), true, strCoorType,new LocationManager.LocationCallback() {
			@Override
			public void onLocationCallback(BDLocation location) {
				if (location != null) {
                   Log.i(TAG,location.getCity());
                    locationBean = new LocationBean();
					locationBean.setProvince(location.getProvince());
					locationBean.setCity(location.getCity());
					locationBean.setDetailAdress(location.getAddrStr());
					locationBean.setLat(location.getLatitude());
					locationBean.setLng(location.getLongitude());
					HashMap<String, String> map = new HashMap<>();
					map.put("longitude",locationBean.getLng()+"");
					map.put("latitude",locationBean.getLat()+"");
					map.put("country",location.getCountry());
					map.put("province",location.getProvince());
					map.put("city",location.getCity());
					map.put("district",location.getDistrict());
					map.put("town",location.getTown());
					map.put("street",location.getStreet());
					Log.d("geo=====", JSON.toJSONString(map));
					mXEngineWebView.callHandler(dto.__event__, new Object[]{new String[]{JSON.toJSONString(map)}}, (OnReturnValue<GeoEventDTO>) new OnReturnValue<GeoEventDTO>() {
						@Override
						public void onValue(GeoEventDTO retValue) {
							Log.d(TAG, "result:" + System.currentTimeMillis());
						}
					});
				}
			}
		});
	}

}

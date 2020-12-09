
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!

  package com.zkty.modules.loaded.jsapi;

  import java.util.List;
  import java.util.Map;
  import java.util.Set;
  import android.webkit.JavascriptInterface;
  import com.alibaba.fastjson.JSONObject;
  import com.zkty.modules.dsbridge.CompletionHandler;
  import com.zkty.modules.engine.annotation.Optional;
  import com.zkty.modules.engine.core.xengine__module_BaseModule;
  import androidx.annotation.Nullable;

  
  class GeoReqDTO {
    @Optional
		public String type;
  }
  
  class ContinousDTO {
    @Optional
		public String __event__;
  }
  
  class GeoResDTO {
    public String longitude;

    public String latitude;
  }
  
  class GeoReverseReqDTO {
    @Optional
		public String type;

    @Optional
		public String longitude;

    @Optional
		public String latitude;
  }
  
  class GeoReverseResDTO {
    public String longitude;

    public String latitude;
  }
  
  class GeoLocationResDTO {
    public String longitude;

    public String latitude;

    public String locationString;
  }
  
  interface xengine__module_geo_i {
    public void _coordinate(GeoReqDTO dto, final CompletionHandler<GeoResDTO> handler);
public void _locate(final CompletionHandler<GeoReverseResDTO> handler);
public void _locate__event__(ContinousDTO dto, final CompletionHandler<GeoLocationResDTO> handler);
  }
  
  
  public abstract class xengine__module_geo extends xengine__module_BaseModule implements xengine__module_geo_i {
    @Override
    public String moduleId() {
      return "com.zkty.module.geo";
    }
  
    @JavascriptInterface
    final public void coordinate(JSONObject obj, final CompletionHandler<Object> handler) {
      GeoReqDTO data= convert(obj,GeoReqDTO.class);
      _coordinate(data, new CompletionHandler<GeoResDTO>() {
        @Override
        public void complete(GeoResDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(GeoResDTO value) { handler.setProgressData(value); }
      });

    }

    @JavascriptInterface
    final public void locate(JSONObject obj, final CompletionHandler<Object> handler) {
      _locate(new CompletionHandler<GeoReverseResDTO>() {
        @Override
        public void complete(GeoReverseResDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(GeoReverseResDTO value) { handler.setProgressData(value); }
      });

    }

    @JavascriptInterface
    final public void locate__event__(JSONObject obj, final CompletionHandler<Object> handler) {
      ContinousDTO data= convert(obj,ContinousDTO.class);
      _locate__event__(data, new CompletionHandler<GeoLocationResDTO>() {
        @Override
        public void complete(GeoLocationResDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(GeoLocationResDTO value) { handler.setProgressData(value); }
      });

    }
  }
  

  
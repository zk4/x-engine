
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!

  package com.zkty.jsi;

  import java.util.List;
  import java.util.Map;
  import java.util.Set;
  import android.webkit.JavascriptInterface;
  import com.alibaba.fastjson.JSON;
  import com.alibaba.fastjson.JSONObject;
  import com.zkty.nativ.jsi.bridge.CompletionHandler;
  import com.zkty.nativ.jsi.JSIModule;
  import androidx.annotation.Nullable;
  import com.zkty.nativ.jsi.annotation.Optional;

  
  class DirectPushDTO {
    public String scheme;

    @Optional
		public String host;

    public String pathname;

    public String fragment;

    @Optional
		public Map<String, Object> query;

    @Optional
		public Map<String, Object> params;
  }
  
  class DirectBackDTO {
    public String scheme;

    public String fragment;
  }
  
  interface xengine_jsi_direct_protocol {
    public void _push(DirectPushDTO dto, final CompletionHandler<Nullable> handler);
public void _back(DirectBackDTO dto, final CompletionHandler<Nullable> handler);
  }
  
  
  public abstract class xengine_jsi_direct extends JSIModule implements xengine_jsi_direct_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.direct";
    }
  
    @JavascriptInterface
    final public void push(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      String defaultStr = "{  \"scheme\": \"omp\",  \"fragment\": \"/\",  \"params\": {    \"hideNavbar\": true  }}";
      jsonobj = mergeDefault(jsonobj, defaultStr);
      DirectPushDTO dto= convert(jsonobj,DirectPushDTO.class);
      _push(dto, new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }

    @JavascriptInterface
    final public void back(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      DirectBackDTO dto= convert(jsonobj,DirectBackDTO.class);
      _back(dto, new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }
  }
  

  
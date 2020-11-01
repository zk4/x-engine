
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

  
  class RouterOpenAppDTO {
    public String type;

    public String uri;

    public String path;
    @Optional
    public String agrs;
  }
  
  interface xengine__module_router_i {
    public void _openTargetRouter(RouterOpenAppDTO dto, final CompletionHandler<Nullable> handler);
  }
  
  
  public abstract class xengine__module_router extends xengine__module_BaseModule implements xengine__module_router_i {
    @Override
    public String moduleId() {
      return "com.zkty.module.router";
    }
  
    @JavascriptInterface
    final public void openTargetRouter(JSONObject obj, final CompletionHandler<Object> handler) {
      RouterOpenAppDTO data= convert(obj,RouterOpenAppDTO.class);
      _openTargetRouter(data, new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }
  }
  

  
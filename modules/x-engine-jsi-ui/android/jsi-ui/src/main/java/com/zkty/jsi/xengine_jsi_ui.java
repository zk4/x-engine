
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!

  package com.zkty.jsi;

  import java.util.List;
  import java.util.Map;
  import java.util.Set;
  import android.webkit.JavascriptInterface;
  import com.alibaba.fastjson.JSON;
  import com.alibaba.fastjson.JSONObject;
  import com.zkty.modules.nativ.jsi.bridge.CompletionHandler;
  import com.zkty.modules.nativ.jsi.JSIModule;
  import androidx.annotation.Nullable;

  
  class NavTitleDTO {
    public String title;

    public String titleColor;

    public Integer titleSize;
  }
  
  class NavHiddenBarDTO {
    public boolean isHidden;

    public boolean isAnimation;
  }
  
  interface xengine_jsi_ui_protocol {
    public void _setNavTitle(NavTitleDTO dto, final CompletionHandler<Nullable> handler);
public void _setNavBarHidden(NavHiddenBarDTO dto, final CompletionHandler<Nullable> handler);
  }
  
  
  public abstract class xengine_jsi_ui extends JSIModule implements xengine_jsi_ui_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.ui";
    }
  
    @JavascriptInterface
    final public void setNavTitle(JSONObject obj, final CompletionHandler<Object> handler) {
      NavTitleDTO data= convert(obj,NavTitleDTO.class);
      _setNavTitle(data, new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }

    @JavascriptInterface
    final public void setNavBarHidden(JSONObject obj, final CompletionHandler<Object> handler) {
      NavHiddenBarDTO data= convert(obj,NavHiddenBarDTO.class);
      _setNavBarHidden(data, new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }
  }
  

  
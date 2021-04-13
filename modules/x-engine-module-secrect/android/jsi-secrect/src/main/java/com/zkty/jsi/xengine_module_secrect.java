
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

  
  class SecretGetDTO {
    public String key;
  }
  
  class SecretDTO {
    public String result;
  }
  
  interface xengine_module_secrect_protocol {
    public void _get(SecretGetDTO dto, final CompletionHandler<SecretDTO> handler);
  }
  
  
  public abstract class xengine_module_secrect extends JSIModule implements xengine_module_secrect_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.module.secrect";
    }
  
    @JavascriptInterface
    final public void get(JSONObject obj, final CompletionHandler<Object> handler) {
      SecretGetDTO data= convert(obj,SecretGetDTO.class);
      _get(data, new CompletionHandler<SecretDTO>() {
        @Override
        public void complete(SecretDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(SecretDTO value) { handler.setProgressData(value); }
      });

    }
  }
  

  

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
  import com.zkty.nativ.core.annotation.Optional;

  
  
  interface xengine_jsi_scan_protocol {
    public void _openScanView(final CompletionHandler<String> handler);
  }
  
  
    public abstract class xengine_jsi_scan extends JSIModule implements xengine_jsi_scan_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.scan";
    }
  
    @JavascriptInterface
    final public void openScanView(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _openScanView(new CompletionHandler<String>() {
        @Override
        public void complete(String retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(String value) { handler.setProgressData(value); }
      });

    }
  }
  

  
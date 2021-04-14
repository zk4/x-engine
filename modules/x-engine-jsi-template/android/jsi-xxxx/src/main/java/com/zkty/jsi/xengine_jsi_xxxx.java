
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

  
  class NamedDTO {
    public String title;

    public Integer titleSize;
  }
  
  class _0_com_zkty_jsi_xxxx_DTO {
    public String a;

    public _1_com_zkty_jsi_xxxx_DTO i;
  }
  
  class _1_com_zkty_jsi_xxxx_DTO {
    public String n1;
  }
  
  interface xengine_jsi_xxxx_protocol {
    public void _simpleMethod(final CompletionHandler<Nullable> handler);    void _simpleMethod();
public void _simpleArgMethod(String dto, final CompletionHandler<String> handler);    String _simpleArgMethod(String dto);
public void _nestedAnonymousObject(final CompletionHandler<_0_com_zkty_jsi_xxxx_DTO> handler);    _0_com_zkty_jsi_xxxx_DTO _nestedAnonymousObject();
public void _namedObject(final CompletionHandler<NamedDTO> handler);    NamedDTO _namedObject();
  }
  
  
  public abstract class xengine_jsi_xxxx extends JSIModule implements xengine_jsi_xxxx_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.xxxx";
    }
  
    @JavascriptInterface
    final public void simpleMethod(JSONObject obj, final CompletionHandler<Object> handler) {
      _simpleMethod(new CompletionHandler<Nullable>() {
        @Override
        public void complete(Nullable retValue) { handler.complete(null); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Nullable value) { handler.setProgressData(null); }
      });

    }
        @JavascriptInterface
        public Object simpleMethod(JSONObject jsonobj) {
          
          _simpleMethod();
          return null;
        }
        

    @JavascriptInterface
    final public void simpleArgMethod(JSONObject obj, final CompletionHandler<Object> handler) {
      String data= convert(obj,String.class);
      _simpleArgMethod(data, new CompletionHandler<String>() {
        @Override
        public void complete(String retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(String value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public String simpleArgMethod(JSONObject jsonobj) {
          String data= convert(obj,String.class);
          return _simpleArgMethod(dto);
        }
        

    @JavascriptInterface
    final public void nestedAnonymousObject(JSONObject obj, final CompletionHandler<Object> handler) {
      _nestedAnonymousObject(new CompletionHandler<_0_com_zkty_jsi_xxxx_DTO>() {
        @Override
        public void complete(_0_com_zkty_jsi_xxxx_DTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(_0_com_zkty_jsi_xxxx_DTO value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public _0_com_zkty_jsi_xxxx_DTO nestedAnonymousObject(JSONObject jsonobj) {
          
          return _nestedAnonymousObject();
        }
        

    @JavascriptInterface
    final public void namedObject(JSONObject obj, final CompletionHandler<Object> handler) {
      _namedObject(new CompletionHandler<NamedDTO>() {
        @Override
        public void complete(NamedDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(NamedDTO value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public NamedDTO namedObject(JSONObject jsonobj) {
          
          return _namedObject();
        }
        
  }
  

  
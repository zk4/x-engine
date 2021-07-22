
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
  
  class _2_com_zkty_jsi_xxxx_DTO {
    public String goodname;

    public Integer price;
  }
  
  class _3_com_zkty_jsi_xxxx_DTO {
    public String name;

    public Integer age;
  }
  
  interface xengine_jsi_xxxx_protocol {
    public void _simpleMethod(final CompletionHandler<Nullable> handler);
public void _simpleMethod();
public void _simpleArgMethod(String dto, final CompletionHandler<String> handler);
public String _simpleArgMethod(String dto);
public void _simpleArgNumberMethod(Integer dto, final CompletionHandler<Integer> handler);
public Integer _simpleArgNumberMethod(Integer dto);
public void _nestedAnonymousObject(final CompletionHandler<_0_com_zkty_jsi_xxxx_DTO> handler);
public _0_com_zkty_jsi_xxxx_DTO _nestedAnonymousObject();
public void _namedObject(final CompletionHandler<NamedDTO> handler);
public NamedDTO _namedObject();
public void _namedObjectWithNamedArgs(NamedDTO dto, final CompletionHandler<NamedDTO> handler);
public NamedDTO _namedObjectWithNamedArgs(NamedDTO dto);
public void _namedObjectWithArgs(_3_com_zkty_jsi_xxxx_DTO dto, final CompletionHandler<_2_com_zkty_jsi_xxxx_DTO> handler);
public _2_com_zkty_jsi_xxxx_DTO _namedObjectWithArgs(_3_com_zkty_jsi_xxxx_DTO dto);
  }
  
  
    public abstract class xengine_jsi_xxxx extends JSIModule implements xengine_jsi_xxxx_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.xxxx";
    }
  
    @JavascriptInterface
    final public void simpleMethod(JSONObject jsonobj, final CompletionHandler<Object> handler) {
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
    final public void simpleArgMethod(String dto, final CompletionHandler<Object> handler) {
      
      _simpleArgMethod(dto, new CompletionHandler<String>() {
        @Override
        public void complete(String retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(String value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public String simpleArgMethod(String dto) {
          
          return _simpleArgMethod(dto);
        }
        

    @JavascriptInterface
    final public void simpleArgNumberMethod(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      Integer dto= convert(jsonobj,Integer.class);
      _simpleArgNumberMethod(dto, new CompletionHandler<Integer>() {
        @Override
        public void complete(Integer retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(Integer value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public Integer simpleArgNumberMethod(JSONObject jsonobj) {
          Integer dto= convert(jsonobj,Integer.class);
          return _simpleArgNumberMethod(dto);
        }
        

    @JavascriptInterface
    final public void nestedAnonymousObject(JSONObject jsonobj, final CompletionHandler<Object> handler) {
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
    final public void namedObject(JSONObject jsonobj, final CompletionHandler<Object> handler) {
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
        

    @JavascriptInterface
    final public void namedObjectWithNamedArgs(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      NamedDTO dto= convert(jsonobj,NamedDTO.class);
      _namedObjectWithNamedArgs(dto, new CompletionHandler<NamedDTO>() {
        @Override
        public void complete(NamedDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(NamedDTO value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public NamedDTO namedObjectWithNamedArgs(JSONObject jsonobj) {
          NamedDTO dto= convert(jsonobj,NamedDTO.class);
          return _namedObjectWithNamedArgs(dto);
        }
        

    @JavascriptInterface
    final public void namedObjectWithArgs(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _3_com_zkty_jsi_xxxx_DTO dto= convert(jsonobj,_3_com_zkty_jsi_xxxx_DTO.class);
      _namedObjectWithArgs(dto, new CompletionHandler<_2_com_zkty_jsi_xxxx_DTO>() {
        @Override
        public void complete(_2_com_zkty_jsi_xxxx_DTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(_2_com_zkty_jsi_xxxx_DTO value) { handler.setProgressData(value); }
      });

    }
        @JavascriptInterface
        public _2_com_zkty_jsi_xxxx_DTO namedObjectWithArgs(JSONObject jsonobj) {
          _3_com_zkty_jsi_xxxx_DTO dto= convert(jsonobj,_3_com_zkty_jsi_xxxx_DTO.class);
          return _namedObjectWithArgs(dto);
        }
        
  }
  

  

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


class _0_com_zkty_jsi_vuex_DTO {
  public String key;

    public String val;
  }

interface xengine_jsi_vuex_protocol {
  
public String _get(String dto);
  
public void _set(_0_com_zkty_jsi_vuex_DTO dto);
}
  

    public abstract class xengine_jsi_vuex extends JSIModule implements xengine_jsi_vuex_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.vuex";
    }
  
        @JavascriptInterface
        public String get(String dto) {
          
          return _get(dto);
        }
        

        @JavascriptInterface
        public Object set(JSONObject jsonobj) {
          _0_com_zkty_jsi_vuex_DTO dto= convert(jsonobj,_0_com_zkty_jsi_vuex_DTO.class);
          _set(dto);
          return null;
        }
        
  }
  

  
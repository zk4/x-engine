
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



interface xengine_jsi_dev_protocol {
  
public void _log(String dto);
}
  

    public abstract class xengine_jsi_dev extends JSIModule implements xengine_jsi_dev_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.dev";
    }
  
        @JavascriptInterface
        public Object log(String dto) {
          
          _log(dto);
          return null;
        }
        
  }
  

  
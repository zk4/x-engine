
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


class StatusDTO {
  public String resultMsg;
  }
  
class _0_com_zkty_jsi_viewer_DTO {
  public String fileUrl;

    public String fileType;

    public String title;
  }

interface xengine_jsi_viewer_protocol {
  public void _openFileReader(_0_com_zkty_jsi_viewer_DTO dto, final CompletionHandler<StatusDTO> handler);
}
  

    public abstract class xengine_jsi_viewer extends JSIModule implements xengine_jsi_viewer_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.viewer";
    }
  
    @JavascriptInterface
    final public void openFileReader(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _0_com_zkty_jsi_viewer_DTO dto= convert(jsonobj,_0_com_zkty_jsi_viewer_DTO.class);
      _openFileReader(dto, new CompletionHandler<StatusDTO>() {
        @Override
        public void complete(StatusDTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(StatusDTO value) { handler.setProgressData(value); }
      });

    }
  }
  

  
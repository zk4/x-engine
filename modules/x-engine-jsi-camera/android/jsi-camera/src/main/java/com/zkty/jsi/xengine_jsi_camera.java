
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

  
  class _0_com_zkty_jsi_camera_DTO {
    @Optional
		public boolean allowsEditing;

    @Optional
		public boolean savePhotosAlbum;

    @Optional
		public Integer cameraFlashMode;

    @Optional
		public String cameraDevice;

    public boolean isbase64;

    public Map<String,String> args;

    @Optional
		public Integer photoCount;
  }
  
  class _1_com_zkty_jsi_camera_DTO {
    public String type;

    public String imageData;
  }
  
  interface xengine_jsi_camera_protocol {
    public void _openImagePicker(_0_com_zkty_jsi_camera_DTO dto, final CompletionHandler<String> handler);
public void _saveImageToPhotoAlbum(_1_com_zkty_jsi_camera_DTO dto, final CompletionHandler<String> handler);
  }
  
  
  public abstract class xengine_jsi_camera extends JSIModule implements xengine_jsi_camera_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.camera";
    }
  
    @JavascriptInterface
    final public void openImagePicker(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _0_com_zkty_jsi_camera_DTO dto= convert(jsonobj,_0_com_zkty_jsi_camera_DTO.class);
      _openImagePicker(dto, new CompletionHandler<String>() {
        @Override
        public void complete(String retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(String value) { handler.setProgressData(value); }
      });

    }

    @JavascriptInterface
    final public void saveImageToPhotoAlbum(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _1_com_zkty_jsi_camera_DTO dto= convert(jsonobj,_1_com_zkty_jsi_camera_DTO.class);
      _saveImageToPhotoAlbum(dto, new CompletionHandler<String>() {
        @Override
        public void complete(String retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(String value) { handler.setProgressData(value); }
      });

    }
  }
  

  
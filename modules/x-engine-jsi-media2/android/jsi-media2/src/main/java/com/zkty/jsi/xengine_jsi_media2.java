
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

  
  class _0_com_zkty_jsi_media2_DTO {
    public Integer index;

    public List<String> imgList;
  }
  
  class _1_com_zkty_jsi_media2_DTO {
    public Integer status;

    public String msg;
  }
  
  class _2_com_zkty_jsi_media2_DTO {
    public String imageUrl;
  }
  
  class _3_com_zkty_jsi_media2_DTO {
    public Integer status;

    public String msg;

    public List<_4_com_zkty_jsi_media2_DTO> data;
  }
  
  class _4_com_zkty_jsi_media2_DTO {
    public String imgID;

    public String type;

    public String thumbnail;
  }
  
  class _5_com_zkty_jsi_media2_DTO {
    @Optional
		public boolean allowsEditing;

    @Optional
		public boolean savePhotosAlbum;

    @Optional
		public Integer cameraFlashMode;

    @Optional
		public String cameraDevice;

    public boolean isbase64;

    @Optional
		public Map<String,String> args;

    @Optional
		public Integer photoCount;
  }
  
  class _6_com_zkty_jsi_media2_DTO {
    public Integer status;

    public String msg;

    public String imgID;

    public String data;
  }
  
  class _7_com_zkty_jsi_media2_DTO {
    public String url;

    public List<String> imgIds;

    @Optional
		public Map<String,String> header;
  }
  
  interface xengine_jsi_media2_protocol {
    
public void _previewImg(_0_com_zkty_jsi_media2_DTO dto);
public void _saveImageToPhotoAlbum(_2_com_zkty_jsi_media2_DTO dto, final CompletionHandler<_1_com_zkty_jsi_media2_DTO> handler);
public void _openImagePicker(_5_com_zkty_jsi_media2_DTO dto, final CompletionHandler<_3_com_zkty_jsi_media2_DTO> handler);
public void _uploadImage(_7_com_zkty_jsi_media2_DTO dto, final CompletionHandler<_6_com_zkty_jsi_media2_DTO> handler);
  }
  
  
    public abstract class xengine_jsi_media2 extends JSIModule implements xengine_jsi_media2_protocol {
    @Override
    public String moduleId() {
      return "com.zkty.jsi.media2";
    }
  
        @JavascriptInterface
        public Object previewImg(JSONObject jsonobj) {
          _0_com_zkty_jsi_media2_DTO dto= convert(jsonobj,_0_com_zkty_jsi_media2_DTO.class);
          _previewImg(dto);
          return null;
        }
        

    @JavascriptInterface
    final public void saveImageToPhotoAlbum(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _2_com_zkty_jsi_media2_DTO dto= convert(jsonobj,_2_com_zkty_jsi_media2_DTO.class);
      _saveImageToPhotoAlbum(dto, new CompletionHandler<_1_com_zkty_jsi_media2_DTO>() {
        @Override
        public void complete(_1_com_zkty_jsi_media2_DTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(_1_com_zkty_jsi_media2_DTO value) { handler.setProgressData(value); }
      });

    }

    @JavascriptInterface
    final public void openImagePicker(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _5_com_zkty_jsi_media2_DTO dto= convert(jsonobj,_5_com_zkty_jsi_media2_DTO.class);
      _openImagePicker(dto, new CompletionHandler<_3_com_zkty_jsi_media2_DTO>() {
        @Override
        public void complete(_3_com_zkty_jsi_media2_DTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(_3_com_zkty_jsi_media2_DTO value) { handler.setProgressData(value); }
      });

    }

    @JavascriptInterface
    final public void uploadImage(JSONObject jsonobj, final CompletionHandler<Object> handler) {
      _7_com_zkty_jsi_media2_DTO dto= convert(jsonobj,_7_com_zkty_jsi_media2_DTO.class);
      _uploadImage(dto, new CompletionHandler<_6_com_zkty_jsi_media2_DTO>() {
        @Override
        public void complete(_6_com_zkty_jsi_media2_DTO retValue) { handler.complete(retValue); }
        @Override
        public void complete() { handler.complete(); }
        @Override
        public void setProgressData(_6_com_zkty_jsi_media2_DTO value) { handler.setProgressData(value); }
      });

    }
  }
  

  
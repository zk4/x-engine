
  package com.zkty.module.camera;

  import java.util.List;
  import java.util.Map;
  import java.util.Set;
  import android.webkit.JavascriptInterface;

  import com.google.gson.Gson;
  import org.json.JSONObject;
  import lombok.Data;

  import com.zkty.modules.dsbridge.CompletionHandler;
  import com.zkty.modules.engine.annotation.Optional;
  import com.zkty.modules.engine.core.xengine__module_BaseModule;

  
  @Data
  class SheetDTO {
    private boolean allowsEditing;

    private boolean savePhotosAlbum;

    private Integer cameraFlashMode;

    private String cameraDevice;

    private String __event__;
  }
  
  @Data
  class MoreDTO {
    private String imageUrl;
  }
  
  interface xengine__module_camera_i {
    
  	public void _openImagePicker(SheetDTO dto, final CompletionHandler<MoreDTO> handler);
    
  }
  
  
  public abstract class xengine__module_camera extends xengine__module_BaseModule implements xengine__module_camera_i {
    @Override
    protected String moduleId() {
      return "com.zkty.module.camera";
    }
  
    @JavascriptInterface
    public void openImagePicker(Object obj, final CompletionHandler<MoreDTO> handler) {
    // todo:
		// 在开发时,参数不满足时,提醒用户参数问题,
		// 在发布时,参数不满足时, 静默处理.
    String s = obj.toString();
		Gson gson = new Gson();

		SheetDTO data= gson.fromJson(s,SheetDTO.class);
		_openImagePicker(data,handler);
    }
    
  }
  

  
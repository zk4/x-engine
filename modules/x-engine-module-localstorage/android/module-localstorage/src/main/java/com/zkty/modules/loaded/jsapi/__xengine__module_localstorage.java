package com.zkty.modules.loaded.jsapi;

import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.loaded.util.SharePreferenceUtils;

import com.zkty.modules.dsbridge.CompletionHandler;

public class __xengine__module_localstorage extends xengine__module_localstorage {


    @Override
    public void _set(StorageSetDTO dto, CompletionHandler<StorageStatusDTO> handler) {
        SharePreferenceUtils.put(ActivityUtils.getCurrentActivity(), dto.isPublic, dto.key, dto.value);
        StorageStatusDTO statusDTO = new StorageStatusDTO();
        statusDTO.result = "success";
        handler.complete(statusDTO);
    }

    @Override
    public void _get(StorageGetDTO dto, CompletionHandler<StorageStatusDTO> handler) {
        String result = (String) SharePreferenceUtils.get(ActivityUtils.getCurrentActivity(), dto.isPublic, dto.key, "");
        StorageStatusDTO statusDTO = new StorageStatusDTO();
        statusDTO.result = result;
        handler.complete(statusDTO);
    }

    @Override
    public void _remove(StorageRemoveDTO dto, CompletionHandler<StorageStatusDTO> handler) {
        SharePreferenceUtils.remove(ActivityUtils.getCurrentActivity(), dto.isPublic, dto.key);
        StorageStatusDTO statusDTO = new StorageStatusDTO();
        statusDTO.result = "success";
        handler.complete(statusDTO);
    }

    @Override
    public void _removeAll(StorageRemoveAllDTO dto, CompletionHandler<StorageStatusDTO> handler) {
        SharePreferenceUtils.clear(ActivityUtils.getCurrentActivity(), dto.isPublic);
        StorageStatusDTO statusDTO = new StorageStatusDTO();
        statusDTO.result = "success";
        handler.complete(statusDTO);
    }

}

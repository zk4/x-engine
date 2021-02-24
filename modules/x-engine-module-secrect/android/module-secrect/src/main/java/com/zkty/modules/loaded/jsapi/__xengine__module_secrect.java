package com.zkty.modules.loaded.jsapi;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.dto.PermissionDto;
import com.zkty.modules.loaded.jsapi.utils.SecretPreferenceUtils;


public class __xengine__module_secrect extends xengine__module_secrect {
    @Override
    public void onAllModulesInited() {

    }

    @Override
    public void _get(SecretGetDTO dto, CompletionHandler<SecretDTO> handler) {
        if (mXEngineWebView != null && mXEngineWebView.getPermission() != null) {
            PermissionDto permissionDto = mXEngineWebView.getPermission();

            if (permissionDto.getPermission() == null
                    || permissionDto.getPermission().getSecrect() == null
                    || permissionDto.getPermission().getSecrect().size() == 0
                    || !permissionDto.getPermission().getSecrect().contains(dto.key)) {
                mXEngineWebView.alertDebugInfo(String.format("没有读取%s的权限", dto.key));
                handler.complete();
                return;
            }
        }

        String result = (String) SecretPreferenceUtils.get(dto.key, "");
        SecretDTO statusDTO = new SecretDTO();
        statusDTO.result = result;
        handler.complete(statusDTO);

    }
}

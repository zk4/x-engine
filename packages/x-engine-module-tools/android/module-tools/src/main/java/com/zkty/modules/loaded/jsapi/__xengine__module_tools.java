package com.zkty.modules.loaded.jsapi;


import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.tools.XEngineUtils;

public class __xengine__module_tools extends xengine__module_tools {

    @Override
    public void _unZipFile(XEUnZipDTO dto, CompletionHandler<String> handler) {
        boolean success = XEngineUtils.unzipFile(dto.filePath, dto.unZipPath);
        if (success) {
            handler.complete();
        } else {
            handler.complete(null);
        }
    }

    @Override
    public void _zipFile(XEZipDTO dto, CompletionHandler<String> handler) {
		boolean success = XEngineUtils.zipFile(dto.filePath, dto.toZipPath);
		if (success) {
			handler.complete();
		} else {
			handler.complete(null);
		}
    }
}

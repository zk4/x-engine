package com.zkty.jsi;


import com.zkty.jsi.xengine_jsi_viewer;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.viewer.CallBack;
import com.zkty.nativ.viewer.Iviewer;
import com.zkty.nativ.viewer.Nativeviewer;

public class JSI_viewer extends xengine_jsi_viewer {
    Nativeviewer iViewer;
    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Iviewer.class);
        if (module instanceof Nativeviewer)
            iViewer = (Nativeviewer) module;
    }


    @Override
    public void _openFileReader(_0_com_zkty_jsi_viewer_DTO dto, CompletionHandler<StatusDTO> handler) {
        iViewer.openFileReader(dto.fileUrl,dto.fileType, dto.title,new CallBack() {
            @Override
            public void success(String msg) {
                StatusDTO statusDTO = new StatusDTO();
                statusDTO.resultMsg = msg;
                handler.complete(statusDTO);
            }
        });
    }
}

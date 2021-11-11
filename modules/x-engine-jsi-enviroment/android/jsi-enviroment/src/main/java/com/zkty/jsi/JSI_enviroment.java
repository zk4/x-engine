package com.zkty.jsi;


import com.zkty.jsi.xengine_jsi_enviroment;

public class JSI_enviroment extends xengine_jsi_enviroment {
    @Override
    protected void afterAllJSIModuleInited() {

    }

    @Override
    public _0_com_zkty_jsi_enviroment_DTO _isHybird() {
        _0_com_zkty_jsi_enviroment_DTO dto = new _0_com_zkty_jsi_enviroment_DTO();
        dto.code = 0;
        dto.msg = "";
        return dto;
    }
}

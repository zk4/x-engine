package com.zkty.engine.jsi.viewer;

import com.zkty.nativ.viewer.bean.NativeViewerInfoBean;

/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc : 模块信息
 */
public class ModelInfoBean {
    private boolean isDefault;
    private String modelId;
    private String modelName;
    private String pic;

    public ModelInfoBean(boolean isDefault,String modelId, String modelName, String pic) {
        this.isDefault = isDefault;
        this.modelName = modelName;
        this.modelId = modelId;
        this.pic = pic;

    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }
}

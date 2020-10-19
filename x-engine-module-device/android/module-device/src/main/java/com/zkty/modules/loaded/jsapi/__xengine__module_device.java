package com.zkty.modules.loaded.jsapi;

import android.app.Activity;

import com.zkty.modules.engine.utils.DensityUtils;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.DeviceUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

public class __xengine__module_device extends xengine__module_device {

    @Override
    public void _getPhoneType(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = DeviceUtils.getSystemModel();
        handler.complete(moreDTO);

    }

    @Override
    public void _getSystemVersion(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = DeviceUtils.getSystemVersion();
        handler.complete(moreDTO);
    }

    @Override
    public void _getUDID(SheetDTO dto, CompletionHandler<MoreDTO> handler) {

        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = "android no udid";
        handler.complete(moreDTO);
    }

    @Override
    public void _getBatteryLevel(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DeviceUtils.getBatteryLevel(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getPreferredLanguage(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = DeviceUtils.getSystemLanguage();
        handler.complete(moreDTO);
    }

    @Override
    public void _getScreenWidth(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getRealWidth(activity));
        handler.complete(moreDTO);

    }

    @Override
    public void _getScreenHeight(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getRealHeight(activity));
        handler.complete(moreDTO);

    }

    @Override
    public void _getSafeAreaTop(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaTop(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaBottom(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaBottom(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaLeft(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaLeft(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaRight(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaRight(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getStatusHeight(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getStatusBarHeight(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getNavigationHeight(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.dipToPixels(activity, 45));
        handler.complete(moreDTO);
    }

    @Override
    public void _getTabBarHeight(SheetDTO dto, CompletionHandler<MoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        MoreDTO moreDTO = new MoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getNavigationBarHeightIfRoom(activity));
        handler.complete(moreDTO);
    }


}

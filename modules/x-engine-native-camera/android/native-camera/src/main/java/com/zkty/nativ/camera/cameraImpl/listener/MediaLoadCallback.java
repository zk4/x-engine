package com.zkty.nativ.camera.cameraImpl.listener;


import com.zkty.nativ.camera.cameraImpl.data.MediaFolder;

import java.util.List;

public interface MediaLoadCallback {

    void loadMediaSuccess(List<MediaFolder> mediaFolderList);
}

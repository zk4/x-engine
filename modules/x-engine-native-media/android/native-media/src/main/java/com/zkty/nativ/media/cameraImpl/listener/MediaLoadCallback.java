package com.zkty.nativ.media.cameraImpl.listener;



import com.zkty.nativ.media.cameraImpl.data.MediaFolder;

import java.util.List;

public interface MediaLoadCallback {

    void loadMediaSuccess(List<MediaFolder> mediaFolderList);
}

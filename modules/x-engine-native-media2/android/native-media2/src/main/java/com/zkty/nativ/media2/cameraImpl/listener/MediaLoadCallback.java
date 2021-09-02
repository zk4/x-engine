package com.zkty.nativ.media2.cameraImpl.listener;



import com.zkty.nativ.media2.cameraImpl.data.MediaFolder;

import java.util.List;

public interface MediaLoadCallback {

    void loadMediaSuccess(List<MediaFolder> mediaFolderList);
}

package com.zkty.modules.loaded.imp.listener;


import com.zkty.modules.loaded.imp.data.MediaFolder;

import java.util.List;

public interface MediaLoadCallback {

    void loadMediaSuccess(List<MediaFolder> mediaFolderList);
}

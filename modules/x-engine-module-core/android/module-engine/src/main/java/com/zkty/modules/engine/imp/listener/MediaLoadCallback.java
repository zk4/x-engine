package com.zkty.modules.engine.imp.listener;


import com.zkty.modules.engine.imp.data.MediaFolder;

import java.util.List;

public interface MediaLoadCallback {

    void loadMediaSuccess(List<MediaFolder> mediaFolderList);
}

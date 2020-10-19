package com.zkty.modules.loaded.imp.provider;

import android.content.Context;

import androidx.core.content.FileProvider;

public class ImagePickerProvider extends FileProvider {

    public static String getFileProviderName(Context context) {
        return context.getPackageName() + ".provider";
    }

}

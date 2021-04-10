package com.zkty.nativ.core.utils;

import android.content.Context;

public interface IApplicationListener {

    void onAppCreate(Context context);

    void onAppLowMemory();
}

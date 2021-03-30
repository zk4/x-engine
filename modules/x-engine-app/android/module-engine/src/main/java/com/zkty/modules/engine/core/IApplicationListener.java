package com.zkty.modules.engine.core;

import android.content.Context;

public interface IApplicationListener {

    void onAppCreate(Context context);

    void onAppLowMemory();
}

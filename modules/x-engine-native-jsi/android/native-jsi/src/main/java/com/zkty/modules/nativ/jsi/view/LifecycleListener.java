package com.zkty.modules.nativ.jsi.view;

import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

public interface LifecycleListener {
    void onCreate();

    void onStart();

    void onRestart();

    void onResume();

    void onPause();

    void onStop();

    void onDestroy();

    void onActivityResult(int requestCode, int resultCode, @Nullable Intent data);

    void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults);

}

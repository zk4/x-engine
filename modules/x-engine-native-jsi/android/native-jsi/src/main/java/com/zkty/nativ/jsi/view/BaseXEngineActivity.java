package com.zkty.nativ.jsi.view;

import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.nativ.core.base.CoreActivity;

import org.jetbrains.annotations.NotNull;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

public class BaseXEngineActivity extends CoreActivity {
    protected Set<LifecycleListener> lifecycleListeners;

    public void addLifeCycleListener(LifecycleListener lifeCycleListener) {
        if (lifecycleListeners == null) {
            lifecycleListeners = new LinkedHashSet<>();
        }

        if (lifeCycleListener != null)
            lifecycleListeners.add(lifeCycleListener);
    }

    public boolean removeLifeCycleListener(LifecycleListener lifeCycleListener) {
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty() && lifecycleListeners.contains(lifeCycleListener)) {
            return lifecycleListeners.remove(lifeCycleListener);
        } else {
            return false;
        }
    }

    public void removeAllLifeCycleListeners() {
        if (lifecycleListeners != null) {
            lifecycleListeners.clear();
            lifecycleListeners = null;
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onStart();
            }
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onResume();
            }
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onPause();
            }
        }
    }


    @Override
    protected void onStop() {
        super.onStop();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onStop();
            }
        }
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onRestart();
            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onDestroy();
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable @org.jetbrains.annotations.Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onActivityResult(requestCode, resultCode, data);
            }
        }
    }


    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull @NotNull String[] permissions, @NonNull @NotNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onRequestPermissionsResult(requestCode, permissions, grantResults);
            }
        }
    }


}

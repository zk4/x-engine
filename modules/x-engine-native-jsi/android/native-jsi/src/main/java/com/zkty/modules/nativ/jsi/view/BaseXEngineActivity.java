package com.zkty.modules.nativ.jsi.view;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Set;

public class BaseXEngineActivity extends AppCompatActivity {
    protected Set<LifecycleListener> lifecycleListeners;

    public void addLifeCycleListener(LifecycleListener lifeCycleListener) {
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
}

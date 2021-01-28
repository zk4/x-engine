package com.zkty.engine.module.xxxx.view.fragment;


import androidx.fragment.app.Fragment;

import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.fargment.XEngineFragment;
import com.zkty.modules.engine.manager.MicroAppsManager;

import java.util.ArrayList;
import java.util.List;


/**
 * 统一管理主页Fragment的获取
 */

public class HomeTabManager {
    private static HomeTabManager instance;

    private List<Fragment> fragments = new ArrayList<>();
    private String[] microAppIds = new String[]{"com.times.microapp.AppcMin", "com.times.microapp.AppcMine"};


    private HomeTabManager() {
        //no instance
    }

    public static HomeTabManager getInstance() {
        if (instance == null) {
            synchronized (HomeTabManager.class) {
                instance = new HomeTabManager();
            }
        }
        return instance;
    }


    public Fragment getFragmentByIndex(int index) {
        if (fragments.size() <= index) {
            String indexUrl = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId(microAppIds[index]);
            fragments.add(XEngineFragment.newInstance(indexUrl));
        }
        return fragments.get(index);
    }

}

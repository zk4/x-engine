package com.zkty.engine.module.xxxx.view.fragment;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import com.zkty.engine.module.xxxx.ConstantValues;
import com.zkty.modules.engine.fargment.XEngineFragment;

import java.util.ArrayList;
import java.util.List;


/**
 * 统一管理主页Fragment的获取
 */

public class HomeTabManager {
    private static HomeTabManager instance;

    private List<Fragment> fragments = new ArrayList<>();


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
            fragments.add(XEngineFragment.newInstance(index, "h5", "https://www.baidu.com"));
        }

        return fragments.get(index);
    }

}

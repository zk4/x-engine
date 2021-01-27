package com.zkty.engine.module.xxxx.view.fragment;

import android.os.Bundle;

import androidx.fragment.app.Fragment;



/**
 * 统一管理主页Fragment的获取
 */

public class HomeTabManager {
    private HomeTabManager instance;

    private HomePageNewFragment homePageFragment;
    private AppPageFragment appPageFragment;

    private MePageFragment mePageFragment;


    private Bundle mBundle;

    private HomeTabManager() {
        //no instance
    }

    public static cn.timesneighborhood.app.b.view.fragment.HomeTabManager getInstance() {
        if (instance == null) {
            synchronized (cn.timesneighborhood.app.b.view.fragment.HomeTabManager.class) {
                instance = new cn.timesneighborhood.app.b.view.fragment.HomeTabManager();
            }
        }
        return instance;
    }


    public Fragment getFragmentByIndex(int index) {
        Fragment fragment = null;
        switch (index) {
            //首页
            case ConstantValues.HOME_INDEX:
                if (homePageFragment == null) {
                    homePageFragment = new HomePageNewFragment();
                }
                fragment = homePageFragment;
                break;

            //应用
            case ConstantValues.APP_INDEX:
                if (appPageFragment == null) {
                    appPageFragment = new AppPageFragment();
                }
                fragment = appPageFragment;
                break;
            //我
            case ConstantValues.ME_INDEX:
                if (mePageFragment == null) {
                    mePageFragment = new MePageFragment();
                }
                fragment = mePageFragment;
                break;
        }

        if (fragment != null) {
            if (mBundle != null) {
                fragment.setArguments(mBundle);
            }
        }
        return fragment;
    }

}

package com.zkty.demo.pedestal;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

/**
 * 统一管理主页Fragment的获取
 */

public class HomeTabManager {
    private static HomeTabManager instance;

    private PageOneFragment homePageFragment;
    private PageTowFragment appPageFragment;

    private PageThreeFragment mePageFragment;


    private Bundle mBundle;

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
        Fragment fragment = null;
        switch (index) {
            //首页
            case ConstantValues.HOME_INDEX:
                if (homePageFragment == null) {
                    homePageFragment = new PageOneFragment();
                }
                fragment = homePageFragment;
                break;

            //应用
            case ConstantValues.APP_INDEX:
                if (appPageFragment == null) {
                    appPageFragment = new PageTowFragment();
                }
                fragment = appPageFragment;
                break;
            //我
            case ConstantValues.ME_INDEX:
                if (mePageFragment == null) {
                    mePageFragment = new PageThreeFragment();
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

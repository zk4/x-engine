package com.zkty.nativ.core;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import com.zkty.nativ.core.base.CoreActivity;

import java.util.Iterator;
import java.util.Stack;

public class ActivityStackManager implements Application.ActivityLifecycleCallbacks {

    private Stack<Activity> stack;

    private ActivityStackManager() {
        stack = new Stack<>();
    }


    public static volatile ActivityStackManager instance;


    public static ActivityStackManager getInstance() {
        if (instance == null) {
            synchronized (ActivityStackManager.class) {
                if (instance == null) {
                    instance = new ActivityStackManager();
                }
            }
        }
        return instance;
    }

    public void register(Application app) {
        app.registerActivityLifecycleCallbacks(this);
    }

    public void unRegister(Application app) {
        app.unregisterActivityLifecycleCallbacks(this);
    }

    /**
     * @param activity 需要添加进栈管理的activity
     */
    private void addActivity(Activity activity) {
        stack.add(activity);
    }

    /**
     * @param activity 需要从栈管理中删除的activity
     * @return
     */
    private boolean removeActivity(Activity activity) {
        return stack.remove(activity);
    }

    /**
     * @param activity 查询指定activity在栈中的位置，从栈顶开始
     * @return
     */
    public int searchActivity(Activity activity) {
        return stack.search(activity);
    }

    public Activity getFirstActivity() {
        if (!stack.isEmpty())
            return stack.get(0);
        return null;
    }

    /**
     * @param activity 将指定的activity从栈中删除然后finish()掉
     */
    public void finishActivity(Activity activity) {
        stack.pop().finish();
    }

    /**
     * 从栈顶开始(除外)向下移除n个activity
     * 同时需要保留栈底Activity
     */
    public void finishActivities(int goal) {
        goal = Math.abs(goal);
        //0，不作操作
        if (goal == 0) return;
        int size = stack.size();
        //超过栈数量时移除除栈顶及栈底外所有act
        if (goal >= size) goal = size - 1;

        for (int i = size - 1; i > size - goal - 1; i--) {
            stack.get(i).finish();
        }
    }

    public int getActivityNum() {
        return stack.size();
    }

    /**
     * @param activity 将指定类名的activity从栈中删除并finish()掉
     */
    public void finishActivityClass(Class<Activity> activity) {
        if (activity != null) {
            Iterator<Activity> iterator = stack.iterator();
            while (iterator.hasNext()) {
                Activity next = iterator.next();
                if (next.getClass().equals(activity)) {
                    iterator.remove();
                    finishActivity(next);
                }
            }
        }
    }

    /**
     * 销毁所有的activity
     */
    public void finishAllActivity() {
        while (!stack.isEmpty()) {
            stack.pop().finish();
        }
    }

    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (activity instanceof CoreActivity)
            addActivity(activity);
    }

    @Override
    public void onActivityStarted(Activity activity) {

    }

    @Override
    public void onActivityResumed(Activity activity) {

    }

    @Override
    public void onActivityPaused(Activity activity) {

    }

    @Override
    public void onActivityStopped(Activity activity) {

    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (activity instanceof CoreActivity)
            removeActivity(activity);
    }
}


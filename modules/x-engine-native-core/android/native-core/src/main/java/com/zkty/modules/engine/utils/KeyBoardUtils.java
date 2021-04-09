package com.zkty.modules.engine.utils;

import android.app.Application;
import android.content.Context;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import com.zkty.modules.nativ.core.XEngineApplication;

/**
 * 打开或关闭软键盘
 */
public class KeyBoardUtils {
	/**
	 * 打卡软键盘
	 *
	 * @param view
	 * @param mContext 上下文
	 */
	public static void openKeybord(View view, Context mContext) {
		InputMethodManager imm = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.showSoftInput(view, InputMethodManager.RESULT_SHOWN);
		imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,
				InputMethodManager.HIDE_IMPLICIT_ONLY);
	}

	/**
	 * 关闭软键盘
	 *
	 * @param view
	 * @param mContext 上下文
	 */
	public static void closeKeybord(View view, Context mContext) {
		InputMethodManager imm = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
	}


	/**
	 * 判断软键盘是否打开 若返回true，则表示输入法打开
	 */

	public static boolean isSoftKeyboardShowed() {
		Application app = XEngineApplication.getApplication();
		InputMethodManager imm = (InputMethodManager) app.getSystemService(Context.INPUT_METHOD_SERVICE);
		return imm.isActive();
	}
}

package com.zkty.engine.module.xxxx.network.utils;

import android.text.TextUtils;
import android.util.Log;

public class LogUtils {

	private static String customTagPrefix = "";
	private static boolean allowD = true;
	private static boolean allowE = true;
	private static boolean allowI = true;
	private static boolean allowV = true;
	private static boolean allowW = true;

	private static String generateTag(StackTraceElement caller) {
		String tag = "%s.%s(L:%d)";
		String callerClazzName = caller.getClassName();
		callerClazzName = callerClazzName.substring(callerClazzName
				.lastIndexOf(".") + 1);
		tag = String.format(tag, callerClazzName, caller.getMethodName(),
				caller.getLineNumber());
		tag = TextUtils.isEmpty(customTagPrefix) ? tag : customTagPrefix + ":"
				+ tag;
		return tag;
	}

	private static CustomLogger customLogger;

	public interface CustomLogger {
		void d(String tag, String content);

		void d(String tag, String content, Throwable tr);

		void e(String tag, String content);

		void e(String tag, String content, Throwable tr);

		void i(String tag, String content);

		void i(String tag, String content, Throwable tr);

		void v(String tag, String content);

		void v(String tag, String content, Throwable tr);

		void w(String tag, String content);

		void w(String tag, String content, Throwable tr);

		void w(String tag, Throwable tr);

	}

	public static void d(String content) {
		if (!allowD) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.d(tag, content);
		} else {
			Log.d(tag, content);
		}
	}

	public static void d(String content, Throwable tr) {
		if (!allowD) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.d(tag, content, tr);
		} else {
			Log.d(tag, content, tr);
		}
	}

	public static void e(String content) {
		if (!allowE) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.e(tag, content);
		} else {
			Log.d(tag, content);
		}
	}

	public static void e(String content, Throwable tr) {
		if (!allowE) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.e(tag, content, tr);
		} else {
			Log.d(tag, content, tr);
		}
	}

	public static void i(String content) {
		if (!allowI) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.i(tag, content);
		} else {
			Log.i(tag, content);
		}
	}

	public static void i(String content, Throwable tr) {
		if (!allowI) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.i(tag, content, tr);
		} else {
			Log.i(tag, content, tr);
		}
	}

	public static void v(String content) {
		if (!allowV) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.v(tag, content);
		} else {
			Log.v(tag, content);
		}
	}

	public static void v(String content, Throwable tr) {
		if (!allowV) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.v(tag, content, tr);
		} else {
			Log.v(tag, content, tr);
		}
	}

	public static void w(String content) {
		if (!allowW) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.w(tag, content);
		} else {
			Log.w(tag, content);
		}
	}

	public static void w(String content, Throwable tr) {
		if (!allowW) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.w(tag, content, tr);
		} else {
			Log.w(tag, content, tr);
		}
	}

	public static void w(Throwable tr) {
		if (!allowW) {
			return;
		}
		StackTraceElement caller = getCallerStackTraceElement();
		String tag = generateTag(caller);

		if (customLogger != null) {
			customLogger.w(tag, tr);
		} else {
			Log.w(tag, tr);
		}
	}

	public static StackTraceElement getCallerStackTraceElement() {
		return Thread.currentThread().getStackTrace()[4];
	}
}

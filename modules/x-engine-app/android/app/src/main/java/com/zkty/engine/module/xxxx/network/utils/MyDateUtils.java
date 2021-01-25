package com.zkty.engine.module.xxxx.network.utils;

import android.text.TextUtils;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 日期工具类
 */
public class MyDateUtils {

    public static final String YYYYMMDD = "yyyyMMdd";
    public static final String YYYYMMDD2 = "yyyy-MM-dd";
    public static final String YYYY_MM_DD = "yyyy.MM.dd";
    public static final String YYYYMM = "yyyyMM";
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd_HH_mm_ss";
    public static final String YYYY_MM_DD_HH_MM_SS1 = "yyyy-MM-dd HH:mm:ss";
    public static final String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";
    public static final String YYYY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";

    /**
     * 获取当前时间的Date对象
     *
     * @return
     */
    public static Date getCurrentDate() {
        Date d = new Date(System.currentTimeMillis());
        String format = format(d, YYYYMMDD);
        return getString2Date(format);
    }

    /**
     * 将指定毫秒值转换为指定格式的字符串表示形式
     *
     * @param milliseconds 时间毫秒值
     * @param pattern      日期格式
     * @return
     */
    public static String getStringDate(long milliseconds, String pattern) {
        Date d = new Date(milliseconds);
        return format(d, pattern);
    }

    /**
     * 获取当前时间字符串表示形式“YYYYMMDD===yyyyMMdd”
     *
     * @return
     */
    public static String getCurrentStringDay() {
        Date d = new Date(System.currentTimeMillis());
        return format(d, YYYYMMDD2);
    }

    /**
     * 获取当前时间字符串表示形式“YYYYMM===yyyyMM”
     *
     * @return yyyyMM
     */
    public static String getCurrentStringMonth() {
        Date d = new Date(System.currentTimeMillis());
        return format(d, YYYYMM);
    }

    /**
     * 获取当前时间的字符串表示形式，自定义格式
     *
     * @param format 日期格式
     * @return
     */
    public static String getCurrentStringDay(String format) {
        Date d = new Date(System.currentTimeMillis());
        return format(d, format);
    }

    /**
     * 获取当前时间的字符串表示形式“YYYY_MM_DD_HH_MM_SS1====yyyy-MM-dd HH:mm:ss”
     *
     * @return yyyy-MM-dd HH:mm:ss
     */
    public static String getCurrentTimeString1() {
        Date d = new Date(System.currentTimeMillis());
        String format = format(d, YYYY_MM_DD_HH_MM_SS1);
        return format;
    }

    /**
     * 获取当前时间的字符串表示形式“YYYY_MM_DD_HH_MM_SS====yyyy-MM-dd_HH_mm_ss”
     *
     * @return yyyy-MM-dd_HH_mm_ss
     */
    public static String getCurrentTimeString2() {
        Date d = new Date(System.currentTimeMillis());
        String format = format(d, YYYY_MM_DD_HH_MM_SS);
        return format;
    }

    /**
     * 获取当前时间的字符串表示形式“YYYYMMDDHHMMSS====yyyyMMddHHmmss”
     *
     * @return yyyyMMddHHmmss
     */
    public static String getCurrentTimeString3() {
        Date d = new Date(System.currentTimeMillis());
        String format = format(d, YYYYMMDDHHMMSS);
        return format;
    }

    /**
     * 获取当前时间的字符串表示形式“YYYYMMDDHHMMSS====yyyyMMddHHmmss”
     *
     * @return yyyyMMddHHmmss
     */
    public static String getCurrentTimeString4() {
        Date d = new Date(System.currentTimeMillis());
        String format = format(d, YYYY_MM_DD_HH_MM);
        return format;
    }

    /**
     * 将date日期对象格式化为指定格式
     *
     * @param date
     * @param pattern 日期格式
     * @return
     */
    public static String format(Date date, String pattern) {
        String dateString = "";
        if (date != null && pattern != null) {
            try {
                dateString = new SimpleDateFormat(pattern).format(date);
            } catch (IllegalArgumentException ex) {
            }
        }
        return dateString;
    }

    /**
     * 获取两个时间的间隔天数
     *
     * @param startDate 开始时间
     * @param endDate   结束时间
     * @return 间隔的天数
     */
    public static int getDaysInterval(Date startDate, Date endDate) {
        long time1 = startDate.getTime();
        long time2 = endDate.getTime();
        long time = time2 - time1;

        long l = time / (1000 * 60 * 60 * 24);

        return Integer.parseInt(String.valueOf(l));

    }

    public static final long MM = 1000 * 60;//分钟
    public static final long HH = MM * 60;//小时
    public static final long DD = HH * 24;//一天
    public static final long MO = DD * 30;//一月
    public static final long YY = 365 * DD;//一年

    /**
     * 获取指定时间到现在的间隔时间字符串表示形式。（time<currentTime否则返回空字符串）
     *
     * @param time 指定的时间（格式是：yyyy-MM-dd HH:mm）
     * @return
     */
    public static String getTimeAfterToNow(String time) {
        String result = "";

        if (TextUtils.isEmpty(time)) {
            return result;
        }
        long newDate = System.currentTimeMillis();//当前时间

        long oldDate = getDateOfLong("yyyy-MM-dd HH:mm", time);//指定时间

        if (newDate < oldDate) {
            return result;
        }

        long gap = newDate - oldDate;

        if (gap < HH) {
            //一小时内,59分钟前
            long lt = gap / MM;

            if (lt == 0) {
                result = "刚刚";
            } else {
                result = lt + "分钟前";
            }

        } else if (gap >= HH && gap < DD) {//一天内,2小时前
            long lt = gap / HH;

            result = lt + "小时前";

        } else if (gap >= DD && gap < MO) {//一个月内
            long lt = gap / DD;
            result = lt + "天前";

        } else if (gap >= MO && gap < YY) {//一年内
            long lt = gap / MO;
            result = lt + "个月前";

        } else if (gap >= YY) {//一年后
            long lt = gap / YY;
            result = lt + "年前";
        } else {
            result = "--";
        }

        return result;
    }

    /**
     * 将指定的时间字符串表示形式，转换为时间的毫秒值
     *
     * @param pattern 日期的模式
     * @param sDate   时间的字符串表示形式
     * @return 时间的毫秒值
     */
    public static long getDateOfLong(String pattern, String sDate) {

        SimpleDateFormat df = new SimpleDateFormat(pattern);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        long time = date.getTime();
        return time;
    }

    /**
     * 获取指定时间指定天数之后的日期Date对象
     *
     * @param sDate    日期的字符串表示形式（YYYYMMDD===yyyyMMdd）
     * @param dayCount 天数
     * @return
     */
    public static Date getDateOfLater(String sDate, int dayCount) {
        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getDateOfLater(date, dayCount);
    }

    /**
     * 获取指定时间指定天数之后的日期字符串表示形式
     *
     * @param sDate    日期的字符串表示形式（YYYYMMDD===yyyyMMdd）
     * @param dayCount 天数
     * @return
     */
    public static String getDateOfLaterString(String sDate, int dayCount) {

        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getDate2String(getDateOfLater(date, dayCount));
    }

    /**
     * 获取指定时间指定天数之后的日期字符串表示形式
     *
     * @param sDate    日期的字符串表示形式（YYYYMMDD===yyyyMMdd）
     * @param dayCount 天数
     * @return
     */
    public static String getDateOfLaterString1(String sDate, int dayCount) {

        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD2);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getDate2String3(getDateOfLater(date, dayCount));
    }

    /**
     * 获取指定时间monthCount月之后的日期Date对象(YYYYMM===yyyyMMdd)
     *
     * @param sDate      yyyyMMdd
     * @param monthCount 月数
     * @return
     */
    public static Date getMonthOfLater(String sDate, int monthCount) {

        SimpleDateFormat df = new SimpleDateFormat(YYYYMM);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getMonthOfLater(date, monthCount);
    }

    /**
     * 获取指定时间monthCount月之后的日期字符串表示形式(YYYYMM===yyyyMMdd)
     *
     * @param sDate      yyyyMMdd
     * @param monthCount 月数
     * @return yyyyMMdd
     */
    public static String getMonthOfLaterString(String sDate, int monthCount) {

        SimpleDateFormat df = new SimpleDateFormat(YYYYMM);
        Date date = null;

        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getDate2String(getMonthOfLater(date, monthCount), YYYYMM);
    }

    /**
     * 获取指定时间（月中的天）dayCount天之后的日期Date对象
     *
     * @param date
     * @param dayCount 月中的天
     * @return
     */
    public static Date getDateOfLater(Date date, int dayCount) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE, dayCount);
        return calendar.getTime();
    }

    /**
     * 获取指定时间monthCount月之后的日期Date对象
     *
     * @param date
     * @param monthCount 月数
     * @return
     */
    public static Date getMonthOfLater(Date date, int monthCount) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.MONTH, monthCount);
        return calendar.getTime();
    }

    /**
     * 获取指定时间monthCount月之后的日期（前一天）Date对象
     *
     * @param date
     * @param monthCount 月数
     * @return
     */
    public static Date getMonthOfLater1(Date date, int monthCount) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.MONTH, monthCount);
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return calendar.getTime();
    }


    /**
     * 获取指定时间yearCount年之后的日期（前一天）Date对象
     *
     * @param date
     * @param yearCount 年数
     * @return
     */
    public static Date getYearOfLater1(Date date, int yearCount) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.YEAR, yearCount);
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return calendar.getTime();
    }

    /**
     * 将指定date对象转换为指定模式的字符串表示形式
     *
     * @param date
     * @param pattern
     * @return
     */
    public static String date2String(Date date, String pattern) {

        String dateString = "";
        if (date != null && pattern != null) {
            try {
                dateString = new SimpleDateFormat(pattern).format(date);
            } catch (IllegalArgumentException ex) {

            }
        }
        return dateString;
    }

    /**
     * 获取date对象的字符串表示形式(YYYYMMDD===yyyyMMdd)
     *
     * @param date yyyyMMdd
     * @return
     */
    public static String getDate2String(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD);
        return df.format(date);
    }

    /**
     * 获取date对象的字符串表示形式(YYYYMMDD===yyyyMMdd)
     *
     * @param date yyyyMMdd
     * @return
     */
    public static String getDate2String1(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(YYYY_MM_DD);
        return df.format(date);
    }

    /**
     * 获取date对象的字符串表示形式(YYYY_MM_DD_HH_MM_SS1===yyyy-MM-dd HH:mm:ss)
     *
     * @param date yyyyMMdd
     * @return
     */
    public static String getDate2String2(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(YYYY_MM_DD_HH_MM_SS1);
        return df.format(date);
    }

    public static String getDate2String3(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD2);
        return df.format(date);
    }

    /**
     * 获取date对象的指定格式的字符串表示形式
     *
     * @param date
     * @param format
     * @return
     */
    public static String getDate2String(Date date, String format) {
        SimpleDateFormat df = new SimpleDateFormat(format);
        return df.format(date);
    }

    /**
     * 将时间毫秒值转换为指定格式的字符串表示形式
     *
     * @param date
     * @param format
     * @return
     */
    public static String getDate2String(long date, String format) {
        Date d = new Date(date);
        SimpleDateFormat df = new SimpleDateFormat(format);
        return df.format(d);
    }

    /**
     * 将字符串日期数据“YYYYMMDD”转换为Date对象
     *
     * @param sDate 日期数据的字符串表示形式“YYYYMMDD”
     * @return
     */
    public static Date getString2Date(String sDate) {

        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 将字符串日期数据“YYYY_MM_DD_HH_MM_SS1”转换为Date对象
     *
     * @param sDate 日期数据的字符串表示形式“YYYY_MM_DD_HH_MM_SS1”
     * @return
     */
    public static Date getString2Date1(String sDate) {
        SimpleDateFormat df = new SimpleDateFormat(YYYY_MM_DD_HH_MM_SS1);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 将字符串日期数据“YYYY_MM_DD_HH_MM_SS1”转换为Date对象
     *
     * @param sDate 日期数据的字符串表示形式“YYYY_MM_DD_HH_MM_SS1”
     * @return
     */
    public static Date getString2Date2(String sDate) {
        SimpleDateFormat df = new SimpleDateFormat(YYYYMMDD2);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 将指定的时间字符串表示形式，转换为“yyyy年MM月dd日”
     *
     * @param sDate     老的时间字符串
     * @param oldformat 老的时间格式
     * @return yyyy年MM月dd日
     */
    public static String getStringDate2StringFormat(String sDate, String oldformat) {

        String newStringDate = "";
        Date string2Date = getString2Date(sDate, oldformat);
        if (string2Date != null) {
            newStringDate = getDate2String(string2Date, "yyyy年MM月dd日");
        }
        return newStringDate;
    }

    /**
     * 将指定时间的字符串表示形式，转换为指定格式的字符串表示形式
     *
     * @param sDate     老的时间字符串表示
     * @param oldformat 老的模式
     * @param newformat 新的模式
     * @return
     */
    public static String getStringDate2StringFormat(String sDate, String oldformat, String newformat) {
        String newStringDate = "";
        Date string2Date = getString2Date(sDate, oldformat);
        if (string2Date != null) {
            newStringDate = getDate2String(string2Date, newformat);
        }
        return newStringDate;
    }

    /**
     * 将指定的时间字符串表示形式转换为date对象
     *
     * @param sDate  时间的字符串表示
     * @param format 时间的老的模式
     * @return
     */
    public static Date getString2Date(String sDate, String format) {

        SimpleDateFormat df = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = df.parse(sDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 将指定的整数年月日拼接为字符串
     *
     * @param iyear
     * @param imonth
     * @param iday
     * @return
     */
    public static String getStringDateByYMH(int iyear, int imonth, int iday) {

        String year = String.valueOf(iyear);

        String month = String.valueOf(imonth);
        String day = String.valueOf(iday);

        if (imonth < 10) {
            month = "0" + month;
        }

        if (iday < 10) {
            day = "0" + day;
        }

        String date = year + month + day;

        return date;
    }

    /**
     * 获取当前日期是星期几<br>
     *
     * @param dt
     * @return 当前日期是星期几
     */
    public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }

    /**
     * 获取当前日期是几月<br>
     *
     * @param dt
     */
    public static String getMonthOfDate(Date dt) {
        String[] month = {"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.MONTH);
        if (w < 0)
            w = 0;
        return month[w];
    }

    /**
     * 获取当前时间
     */
    public static String getCurrentTime() {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(d);
    }

    /**
     * 获取当前时间--字符串形式
     *
     * @return
     */
    public static String getCurrentDateStr() {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(d);
    }

    /**
     * 作者：沈钦伟
     * 功能:保留2位小数，不足补0
     */

    public static String getDoubleNum(double number) {

        DecimalFormat df = new DecimalFormat("0.00");
        // System.out.println("=====hehe==="+df.format(number));
        return df.format(number);
    }

    /**
     * 获取某月的最后一天
     *
     * @throws
     * @Title:getLastDayOfMonth
     * @Description:
     * @param:@param year
     * @param:@param month
     * @param:@return
     * @return:String
     */

    public static String getLastDayOfMonth(int year, int month) {

        Calendar cal = Calendar.getInstance();

        //设置年份

        cal.set(Calendar.YEAR, year);

        //设置月份

        cal.set(Calendar.MONTH, month - 1);

        //获取某月最大天数

        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        //设置日历中月份的最大天数

        cal.set(Calendar.DAY_OF_MONTH, lastDay);

        //格式化日期

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String lastDayOfMonth = sdf.format(cal.getTime());

        return lastDayOfMonth;

    }

    /**
     * 获取这个月的最后一天
     *
     * @throws
     * @Title:getLastDayOfCurrentMonth
     * @Description:
     * @param:@param year
     * @param:@param month
     * @param:@return
     * @return:String
     */

    public static String getLastDayOfCurrentMonth() {

        Calendar cal = Calendar.getInstance();

        //获取某月最大天数

        int lastDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH);

        //设置日历中月份的最大天数

        cal.set(Calendar.DAY_OF_MONTH, lastDay);

        //格式化日期

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String lastDayOfMonth = sdf.format(cal.getTime());

        return lastDayOfMonth;

    }

    /**
     * 获取某月的第一天
     *
     * @throws
     * @Title:getLastDayOfMonth
     * @Description:
     * @param:@param year
     * @param:@param month
     * @param:@return
     * @return:String
     */

    public static String getFirstDayOfMonth(int year, int month) {

        Calendar cal = Calendar.getInstance();

        //设置年份

        cal.set(Calendar.YEAR, year);

        //设置月份

        cal.set(Calendar.MONTH, month - 1);

        //获取某月最大天数

        int lastDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH);

        //设置日历中月份的最大天数

        cal.set(Calendar.DAY_OF_MONTH, lastDay);

        //格式化日期

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String lastDayOfMonth = sdf.format(cal.getTime());

        return lastDayOfMonth;

    }

    /**
     * 获取这个月的第一天
     *
     * @throws
     * @Title:getFirstDayOfCurrentMonth
     * @Description:
     * @param:@param year
     * @param:@param month
     * @param:@return
     * @return:String
     */

    public static String getFirstDayOfCurrentMonth() {

        Calendar cal = Calendar.getInstance();

        //获取某月最大天数

        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        //设置日历中月份的最大天数

        cal.set(Calendar.DAY_OF_MONTH, lastDay);

        //格式化日期

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String lastDayOfMonth = sdf.format(cal.getTime());

        return lastDayOfMonth;

    }


}

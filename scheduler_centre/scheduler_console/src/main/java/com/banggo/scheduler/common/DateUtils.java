package com.banggo.scheduler.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	/**
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String format(Date date, String pattern) {
		if (date == null || pattern == null) {
			return "";
		}

		SimpleDateFormat df = new SimpleDateFormat(pattern);
		return df.format(date);
	}
	
	 /**
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String format(Date date){
		   if (date == null){
			   return "";
		   }
		   
		   SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   return df.format(date);
	   }
	   
	   

}

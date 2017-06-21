package com.banggo.scheduler.manager.util;

import java.util.UUID;

import org.apache.commons.lang.StringUtils;

import com.banggo.scheduler.dao.dataobject.ScheJob;

public class JobUtils {
	public static String buildJobGroupName(ScheJob job) {
		if (job == null){
			return StringUtils.EMPTY;
		}
		
		return spliceByColon(job.getAppName(),job.getJobGroup());
	}

	public static String buildJobName(ScheJob job) {
		if (job == null){
			return StringUtils.EMPTY;
		}
		return spliceByColon(job.getAppName(),job.getJobName());
	}
	
	
	private static String spliceByColon(String str1, String str2){
		return StringUtils.trimToEmpty(str1) + ":" + StringUtils.trimToEmpty(str2);
	}
	
	
	/**
	 * 以java UUID方式获取唯一性字符串值
	 * @param hostId
	 * @return
	 */
	public static String genExecuterNo(String hostId){
		/*StringBuilder rs = new StringBuilder();
		
		// 8位日期
		SimpleDateFormat sf = new SimpleDateFormat("ssmmHHddMMyy"); 
		String timePart = Long.toString(Long.valueOf(sf.format(new Date())),36);
        rs.append(StringUtils.leftPad(timePart, 8, '0'));
        
        // 1位机器代码
        int sum = 0;
        for (int i = 0; hostId != null && i < hostId.length(); i ++){
			char c = hostId.charAt(i);
			sum += Character.getNumericValue(c);
		}
        String hostPart = Long.toString(sum%36 ,36);
        rs.append(hostPart);
        
        // 2位随机数
        String randomPart = Long.toString(Math.round( 36 * 36 * Math.random()),36);
		rs.append(StringUtils.leftPad(randomPart, 2, '0'));*/
		
		return UUID.randomUUID().toString().replace("-", "");
		
	}
	
	public static void main(String[] args) {
		String hostId="pc243931334821071077";
		
		int sum = 0;
        for (int i = 0; hostId != null && i < hostId.length(); i ++){
			char c = hostId.charAt(i);
			sum += Character.getNumericValue(c);
		}
        String hostPart = Long.toString(sum%36 ,36);
        System.out.println(hostPart);
		
        long s = System.currentTimeMillis();
        for (int i = 0; i < 100; i ++) {
        	System.out.println("new:" + genExecuterNo("1"));
        }
        
        System.out.println("---------cost: " + (System.currentTimeMillis() - s) + " ms");
        
	}
	
}

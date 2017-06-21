package com.banggo.scheduler.job.builder;

import java.util.Map;

public class ScheJobBuilderFactory {
	private Map registeMap;

	public void setRegisteMap(Map registeMap) {
		this.registeMap = registeMap;
	}

   public ScheJobBuilder getScheJobBuilder(int jobType){
	   if (registeMap == null) {
			return null;
		}
		String key = String.valueOf(jobType);
       
		if (registeMap.containsKey(key)){
			return (ScheJobBuilder)registeMap.get(key);
		}else{
			return null;
		}
		
   }
  
}

package com.banggo.scheduler.task;

import java.util.Collections;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import com.banggo.scheduler.frontctl.FrontController;

public class TaskExecuteRequest {
	private String taskName;
	private String taskGroup;
	private String execNo;
	private String appExecNo;
	private Map params;
	private String taskClassName;
	private String callbackUrl;
	

	public TaskExecuteRequest() {

	}

	public TaskExecuteRequest(String taskName, String taskGroup, Map params) {
		this.taskGroup = taskGroup;
		this.taskName = taskName;
		this.params = params;
		
		// 尝试获得execNo和appExecNo
		this.execNo = getParam(FrontController.EXECUTE_NO_KEY);
		this.appExecNo = getParam(FrontController.APP_EXECUTE_NO_KEY);
		
		// 尝试获得className
		this.taskClassName = getParam(FrontController.TASK_CLASS_NAME_KEY);
		
		// 尝试获得callbackUrl
		this.callbackUrl = getParam(FrontController.CALL_BACK_URL_KEY);
	}

	
	public String getParam(String key) {
		if (params == null || !params.containsKey(key)) {
			return null;
		}
		return String.valueOf(params.get(key));
	}
	
	public String getCallbackUrl() {
		return callbackUrl;
	}
	
	public String getTaskClassName() {
		return taskClassName;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getTaskGroup() {
		return taskGroup;
	}

	public void setTaskGroup(String taskGroup) {
		this.taskGroup = taskGroup;
	}

	public String getExecNo() {
		return execNo;
	}

	public void setExecNo(String execNo) {
		this.execNo = execNo;
	}

	public String getAppExecNo() {
		return appExecNo;
	}

	public void setAppExecNo(String appExecNo) {
		this.appExecNo = appExecNo;
	}

	public void setParams(Map params) {
		this.params = params;
	}
	
	public Map<String,String> getParams() {
		return Collections.unmodifiableMap(params);
	}

	@Override
	public String toString() {
		return "TaskExeceteRequest [taskName=" + taskName + ", taskGroup="
				+ taskGroup + ", execNo=" + execNo + ", appExecNo=" + appExecNo
				+ ", params=" + printMap(params) + ", taskClassName=" + taskClassName
				+ ", callbackUrl=" + callbackUrl + "]";
	}
	
	private String printMap(Map params) {
		if (params == null){
			return "";
		}
		StringBuffer buffer = new StringBuffer("{");
		Set<Map.Entry> set = params.entrySet();
		for (Iterator iterator = set.iterator(); iterator.hasNext();) {
			Entry entry = (Entry) iterator.next();
			buffer.append(entry.getKey() + " = " + entry.getValue() + " ;");
		}

		buffer.append("}");
		return buffer.toString();
	}
}

package com.banggo.scheduler.event;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;

public class ExecuteFinishedEvent implements Event {
  public static final String eventName = "ExecuteFinishEvent";
	
	private ScheExecuter scheExecuter;
	
	public ExecuteFinishedEvent(ScheExecuter scheExecuter) {
		this.scheExecuter = scheExecuter;
	}
	
	public ScheExecuter getScheExecuter() {
		return scheExecuter;
	}

	@Override
	public String getEventName() {
		return eventName;
	}

}

package com.banggo.scheduler.executer.member.handler;

import java.util.Map;

@SuppressWarnings("rawtypes")
public class NodeHandlerFactory {
    private final static String DEFAULT = "default";
    
    
	private Map registeMap;

	public void setRegisteMap(Map registeMap) {
		this.registeMap = registeMap;
	}

	public NodeHandler getHandler(int nodeType) {
		if (registeMap == null) {
			return null;
		}
		String key = String.valueOf(nodeType);
        
		if (registeMap.containsKey(key)){
			return (NodeHandler)registeMap.get(key);
		}else{
			return (NodeHandler)registeMap.get(DEFAULT);
		}
		
	}

}

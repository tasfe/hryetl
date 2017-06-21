package com.banggo.scheduler.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

@SuppressWarnings({ "rawtypes", "unchecked" })
public class JsonUtils {
	
	public static String toJsonString(Map data) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			
			Map temp = new HashMap();
			Iterator keyIterator = data.keySet().iterator();
			while (keyIterator.hasNext()) {
				Object key = keyIterator.next();
				if (key instanceof String && ((String) key).indexOf(".") == -1) { // 排除spring mvn 包含的key/value
					temp.put(key, data.get(key));
				}
			}
			return mapper.writeValueAsString(temp);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}

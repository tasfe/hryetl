package com.banggo.scheduler.event;

import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.beans.factory.InitializingBean;

public class EventPublisher implements InitializingBean {
	private List<Listener> registListeners = new CopyOnWriteArrayList<Listener>(); 
	
	private List<Listener> listenerList;
	public void setListenerList(List<Listener> listenerList) {
		this.listenerList = listenerList;
	}

	/**
	 * @param listener
	 * @return
	 */
	public  boolean registListener(Listener listener) {
		if (listener == null){
			return false;
		}
		
		return registListeners.add(listener);
	}
	
	/**
	 * @param listener
	 * @return
	 */
	public  boolean unregistListener(Listener listener) {
		boolean result = false;
		
		if (listener == null || registListeners.size() == 0){
			return result;
		}
		
		registListeners.remove(listener);

		return result;
	}
	
	/**
	 * @param e
	 */
	public void publish(Event e){
		if (e == null){
			return ;
		}
		
		for (Iterator<Listener> iterator = registListeners.iterator(); iterator.hasNext();) {
			Listener listener =  iterator.next();
			if (listener.isListenTo(e)){
				listener.onEvent(e);
			}
		}
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		if (listenerList != null){
			for (Iterator<Listener> iterator = listenerList.iterator(); iterator.hasNext();) {
				Listener obj =  iterator.next();
				registListener(obj);
				
			}
		}
	}
}

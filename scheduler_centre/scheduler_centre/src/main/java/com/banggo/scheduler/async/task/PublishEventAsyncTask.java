package com.banggo.scheduler.async.task;

import com.banggo.scheduler.async.task.AsyncTask;
import com.banggo.scheduler.event.Event;
import com.banggo.scheduler.event.EventPublisher;

public class PublishEventAsyncTask extends AsyncTask<Void> {

	private EventPublisher eventPublisher;

	private Event event;

	public PublishEventAsyncTask(EventPublisher eventPublisher, Event event) {
		if (eventPublisher == null){
			throw new IllegalArgumentException("eventPublisher is null.");
		}
		
		this.event = event;
		this.eventPublisher = eventPublisher;
	}

	@Override
	public Void doInAsync() {
		eventPublisher.publish(event);  
		return null;
	}

}

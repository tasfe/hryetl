package com.banggo.scheduler.event;

public interface Listener {
	public void onEvent(Event e);

	public boolean isListenTo(Event e);
}

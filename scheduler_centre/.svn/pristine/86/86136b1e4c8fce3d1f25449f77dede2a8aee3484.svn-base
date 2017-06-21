package com.banggo.scheduler.mapping;

import java.util.Comparator;
import java.util.SortedSet;
import java.util.TreeSet;

public class TaskMappingRepository {
	private SortedSet<TaskMapping> repo = new TreeSet<TaskMapping>(
			new Comparator<TaskMapping>(

			) {
				public int compare(TaskMapping o1, TaskMapping o2) {
					return (o1.getOrder() > o2.getOrder()) ? 1 : -1;
				}
			});
	
	private static TaskMappingRepository instance = new TaskMappingRepository();
	private TaskMappingRepository(){
		
	}
	
	public static TaskMappingRepository getInstance(){
		return instance;
	}
	
	public void add(TaskMapping mapping){
		if (mapping == null){
			return;
		}
		
		repo.add(mapping);
	}
	
	public TaskMapping[] getTaskMappings(){
		return repo.toArray(new TaskMapping[0]);
	}
}

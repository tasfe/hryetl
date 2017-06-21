package com.banggo.scheduler.constant;

public final class ScheChainConstant {
	public static final int START_JOB_ID = -999; // 任务链起始节点任务ID,虚拟的任务

	public static boolean isBarrierJob(int scheJobId) {
		return scheJobId >= -909 && scheJobId <= -900;
	}

}

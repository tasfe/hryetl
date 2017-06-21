package com.banggo.scheduler.interfaces;

import com.banggo.scheduler.po.CallbackPO;
import com.banggo.scheduler.ro.CallbackRO;

public interface TaskCallback {

	/**
	 * 应用执行完后回调
	 * 
	 * @param po
	 * @return
	 */
	public CallbackRO callback(CallbackPO po);
}

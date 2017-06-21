package com.banggo.scheduler.dao.dataobject;

public enum ScheExecuterStatus {
	init("0", "初始"), processing("1", "执行中"), finished("2", "执行结束"), unknow("-1", "未知"), triggerFailed("-2", "调度失败");

	private String code;
	private String name;

	private ScheExecuterStatus(String code, String name) {
		this.code = code;
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	/**
	 * 根据code找到相应的枚举值
	 * @param code
	 * @return
	 */
	public static ScheExecuterStatus toEnum(String code) {
		ScheExecuterStatus[] values = values();
		for (ScheExecuterStatus scheExecuterStatus : values) {
			if (scheExecuterStatus.getCode().equals(code)) {
				return scheExecuterStatus;
			}
		}
		return null;
	}
}

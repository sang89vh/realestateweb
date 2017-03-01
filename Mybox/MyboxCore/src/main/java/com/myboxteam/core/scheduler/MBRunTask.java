package com.myboxteam.core.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MBRunTask {
	private static final Logger logger = LoggerFactory
			.getLogger(MBRunTask.class);

	public void doTask() {
		logger.debug("Start task");

		logger.debug("End task");
	}
}

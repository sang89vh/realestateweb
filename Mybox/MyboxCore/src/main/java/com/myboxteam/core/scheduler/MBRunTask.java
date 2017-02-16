package com.myboxteam.core.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.myboxteam.core.service.IMB0002Service;

public class MBRunTask {
	private static final Logger logger = LoggerFactory
			.getLogger(MBRunTask.class);
	@Autowired
	private IMB0002Service mb0002Service;

	public void doTask() {
		logger.debug("Start task");

		logger.debug("End task");
	}
}

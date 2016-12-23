package com.re.realestate.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.re.realestate.service.IFF0002Service;

public class FFRunTask {
	private static final Logger logger = LoggerFactory
			.getLogger(FFRunTask.class);
	@Autowired
	private IFF0002Service ff0002Service;

	public void doTask() {
		logger.debug("Start task");

		logger.debug("End task");
	}
}

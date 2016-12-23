package com.re.realestate.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.re.realestate.service.IRe0002Service;

public class ReRunTask {
	private static final Logger logger = LoggerFactory
			.getLogger(ReRunTask.class);
	@Autowired
	private IRe0002Service re0002Service;

	public void doTask() {
		logger.debug("Start task");

		logger.debug("End task");
	}
}

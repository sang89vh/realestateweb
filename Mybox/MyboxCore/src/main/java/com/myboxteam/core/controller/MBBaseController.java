package com.myboxteam.core.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.ocpsoft.prettytime.PrettyTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

public class MBBaseController {
	
	protected static final Logger logger = LogManager.getLogger(MBBaseController.class);
	@Autowired
	protected MessageSource messageSource;
	
	@Autowired
	protected PrettyTime prettyTime;
	
	@Autowired
	protected ObjectMapper objectMapper;
}

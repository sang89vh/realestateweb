package com.myboxteam.core.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.myboxteam.core.config.MBConfig;

public class MBBaseController {
	@Autowired
	protected MessageSource messageSource;
	
	
}

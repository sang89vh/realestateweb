package com.re.realestate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.re.realestate.config.ReConfig;

public class ReBaseController {
	@Autowired
	protected MessageSource messageSource;
	
	
}

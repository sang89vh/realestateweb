package com.myboxteam.core.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * Just only index, view,
 * 
 * @author jack
 *
 */
@Controller
@SessionAttributes("language")
@RequestMapping("/language")
public class MB0002Controller extends MBBaseController {

	private static final Logger logger = LogManager
			.getLogger(MB0002Controller.class);

	@RequestMapping(value = "/change-to", method = RequestMethod.GET)
	public @ResponseBody Boolean login(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("lang") String lang) {
		
		logger.info("Change location to:"+lang);
		LocaleResolver localeResolver = RequestContextUtils
				.getLocaleResolver(request);
		localeResolver.setLocale(request, response,
				StringUtils.parseLocaleString(lang));

		return true;
	}
}

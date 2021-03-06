package com.myboxteam.core.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;

@ControllerAdvice
public class ExceptionHandelerAdvice {
	protected Logger logger = LogManager
			.getLogger(ExceptionHandelerAdvice.class);

	@Autowired
	protected MessageSource messageSource;

	@ExceptionHandler(MBException.class)
	public @ResponseBody RestError handleCustomException(MBException wbex,
			HttpServletRequest request, HttpServletResponse response) {

		logger.info("ExceptionHandelerAdvice:handle controller exception");

		wbex.printStackTrace();

		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

		String method = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);

		RestError restError = wbex.transformToRestError(messageSource,LocaleContextHolder.getLocale(), method);

		return restError;

	}

}
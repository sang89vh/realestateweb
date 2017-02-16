package com.myboxteam.core.restutils;

import org.springframework.http.HttpStatus;
import org.springframework.web.client.DefaultResponseErrorHandler;

public class MBResponseErrorHandler extends DefaultResponseErrorHandler {
	
	protected boolean hasError(HttpStatus statusCode) {
		if (statusCode.equals(HttpStatus.INTERNAL_SERVER_ERROR)){
			return false;
		}
		return (statusCode.series() == HttpStatus.Series.CLIENT_ERROR ||
				statusCode.series() == HttpStatus.Series.SERVER_ERROR);
	}

}

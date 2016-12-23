package com.re.realestate.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class FFConfig implements FFCommCode {
	
	public static String COMPANY_PROFILE_URL;

	@Value("${iframe.company.url}")
	public void setCmpanyProfileUrl(String url) {
		COMPANY_PROFILE_URL = url;
	}
	

}

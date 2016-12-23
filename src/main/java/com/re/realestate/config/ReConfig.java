package com.re.realestate.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ReConfig implements ReCommCode {
	
	public static String EXMAPLE_CONFIG;

	@Value("${exmaple.config}")
	public void setExmapleConfig(String url) {
		EXMAPLE_CONFIG = url;
	}
	

}

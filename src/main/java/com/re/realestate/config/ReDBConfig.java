package com.re.realestate.config;

import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;



@Configuration
public class ReDBConfig {

	@Bean(name = "ffSystemParameter")
	public Map getSystemParameter() {
		return null;
	}

	@Bean(name = "ffMenu")
	public Map getMenu() {
		return null;
	}
}

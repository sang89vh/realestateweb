package com.myboxteam.core.config;

import java.util.Map;

import org.parse4j.Parse;
import org.parse4j.util.ParseRegistry;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;



@Configuration
public class MBBeanConfig {

	@Bean(name = "ffSystemParameter")
	public Map getSystemParameter() {
		return null;
	}

	@Bean(name = "ffMenu")
	public Map getMenu() {
		return null;
	}
	
	@Bean(name = "jackObjMapper")
	public ObjectMapper getObjectMapper() {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(MapperFeature.USE_STD_BEAN_NAMING, true);
		return mapper;
	}
	
	@Bean(name = "parse")
	public String getParse() {
		
		 Parse.initialize(MBConfig.APP_ID, MBConfig.APP_REST_API_ID, MBConfig.CUSTOM_SERVER_PATH);
		 return Parse.getApplicationId();
	}
}

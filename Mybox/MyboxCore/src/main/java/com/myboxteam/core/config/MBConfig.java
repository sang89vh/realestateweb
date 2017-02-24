package com.myboxteam.core.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MBConfig implements MBCommCode {
	
	public static String EXMAPLE_CONFIG;

	@Value("${exmaple.config}")
	public void setExmapleConfig(String url) {
		EXMAPLE_CONFIG = url;
	}
	
	public static String PATH_IMAGE;
	@Value("${path.image}")
	public void setPathImage(String path) {
		PATH_IMAGE = path;
	}
	
	public static String SERVER_IMAGE;
	@Value("${server.image}")
	public void setServerImage(String path) {
		SERVER_IMAGE = path;
	}

}

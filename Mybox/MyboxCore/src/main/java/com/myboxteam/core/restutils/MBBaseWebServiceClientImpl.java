package com.myboxteam.core.restutils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

public class MBBaseWebServiceClientImpl implements MBBaseWebServiceClient {
	
	protected RestTemplate restTemplate;
	private String serviceUrl;

	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}
	public String getServiceUrl() {
		return serviceUrl;
	}
	
	
	public MBBaseWebServiceClientImpl() { }
	
	public MBBaseWebServiceClientImpl(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
		MBResponseErrorHandler errorHandler = new MBResponseErrorHandler();
		restTemplate.setErrorHandler(errorHandler);
	}

	
	@Autowired
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
		MBResponseErrorHandler errorHandler = new MBResponseErrorHandler();
		restTemplate.setErrorHandler(errorHandler);
	}

}

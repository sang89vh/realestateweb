package com.myboxteam.core.utils;

import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONObject;
import org.parse4j.ParseGeoPoint;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

public class MapUtils {
	private static String mapAPIUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=vi&radius=10000&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&location=";
	private static String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36";

	public static JSONArray searchPlaceNear(ParseGeoPoint geoPoint) {
		RestTemplate restTemplate = new RestTemplate();
		String url = mapAPIUrl+geoPoint.getLatitude()+","+geoPoint.getLongitude();
		// Set XML content type explicitly to force response in XML (If not spring gets response in JSON)
		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		headers.set("user-agent",userAgent);
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);

		ResponseEntity<String> response =restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		String responseBody = response.getBody();
		JSONObject jo = new JSONObject(responseBody);
		JSONArray data = jo.getJSONArray("results");
		
		return data;
	}
}

package com.myboxteam.realestate.controller;

import java.util.List;
import java.util.Map;

import org.parse4j.ParseException;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.myboxteam.core.controller.MBBaseController;
import com.myboxteam.core.utils.MBUtils;
import com.myboxteam.realestate.form.GeoBox;
import com.myboxteam.realestate.form.LocationForm;

@Controller
@SessionAttributes("map")
@RequestMapping("/map")
public class MapController extends MBBaseController {

	@RequestMapping(value = "/search-place")
	public @ResponseBody List<Map<String, Object>> searchPlace(
			@ModelAttribute("geoBox") GeoBox geoBox,
			@RequestParam(value="skip",required=false,defaultValue="0") Integer skip)
			throws ParseException {

		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		// query.whereEqualTo("playerName", "Dan Stemkoski");
		ParseGeoPoint southwestOfSF = new ParseGeoPoint(geoBox.getSouthwestLatitude(), geoBox.getSouthwestLongitude());
		ParseGeoPoint northeastOfSF = new ParseGeoPoint(geoBox.getNortheastLatitude(), geoBox.getNortheastLongitude());
		query.whereWithinGeoBox("location", southwestOfSF, northeastOfSF);
		query.skip(skip);
		query.limit(50);
		List<ParseObject> places = query.find();
		System.out.println("======skip=======");
		System.out.println(skip);
		System.out.println("=================");

		return MBUtils.convertListParseToMap(places);

	}
	@RequestMapping(value = "/get-polygon")
	public @ResponseBody List<Map<String, Object>> polygon(
			@RequestParam(value="name",required=true) String name)
			throws ParseException {

		ParseQuery<ParseObject> query = ParseQuery.getQuery("kml");
		query.whereContains("keyword", MBUtils.removeAccent(name).toLowerCase());
		List<ParseObject> places = query.find();

		return MBUtils.convertListParseToMap(places);

	}
	@RequestMapping(value = "/near-place")
	public @ResponseBody List<Map<String, Object>> nearPlace(
			@ModelAttribute("locationForm") LocationForm locationForm,
			@RequestParam(value="skip",required=false,defaultValue="0") Integer skip)
					throws ParseException {
		
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		// query.whereEqualTo("playerName", "Dan Stemkoski");
//		 106.6924142, 
//	        10.7683017
		ParseGeoPoint geo=new ParseGeoPoint(locationForm.getLatitude(),locationForm.getLongitude());
//		query.whereWithinKilometers("location",geo,10);
		query.whereNear("location",geo);
//		query.skip(skip);
//		query.limit(200);
		List<ParseObject> places = query.find();
		System.out.println("======skip=======");
		System.out.println(skip);
		System.out.println("=================");
		
		return MBUtils.convertListParseToMap(places);
		
	}

	
}

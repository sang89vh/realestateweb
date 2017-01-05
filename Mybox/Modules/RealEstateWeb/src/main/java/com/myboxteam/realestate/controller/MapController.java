package com.myboxteam.realestate.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.parse4j.ParseException;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.parse4j.util.ParseRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.myboxteam.core.controller.MBBaseController;
import com.myboxteam.realestate.model.RePlace;

@Controller
@SessionAttributes("map")
@RequestMapping("/map")
public class MapController extends MBBaseController {

	@RequestMapping(value = "/search-place", method = RequestMethod.GET)
	public @ResponseBody List<Map> searchPlace() throws ParseException {

		List<Map> data = new ArrayList<Map>();
		Map h1 = new HashMap();
		Map l1 = new HashMap();
		h1.put("title", "House 1");
		l1.put("lat", 21.040165999999998);
		l1.put("lng", 105.79480189999999);
		h1.put("location", l1);
		data.add(h1);
		
		Map h2 = new HashMap();
		Map l2 = new HashMap();
		h2.put("title", "House 2");
		l2.put("lat", 21.020165999999998);
		l2.put("lng", 105.77480189999999);
		h2.put("location", l2);
		data.add(h2);
		
		return data;
	}
	@RequestMapping(value = "/search-place2", method = RequestMethod.GET)
	public @ResponseBody List<JSONObject> searchPlace3() throws ParseException {
//		ParseObject gameScore = new ParseObject("RePlace");
//		gameScore.put("title", "House 1");		
//		ParseGeoPoint point = new ParseGeoPoint(21.040165999999998, 105.79480189999999);
//		gameScore.put("location", point);
//		gameScore.save();
//		
//		ParseObject gameScore3 = new ParseObject("RePlace");
//		gameScore3.put("title", "House 3");		
//		ParseGeoPoint point3 = new ParseGeoPoint(21.020165999999998, 105.77480189999999);
//		gameScore3.put("location", point3);
//		gameScore3.save();
		ParseRegistry.registerSubclass(RePlace.class);
		
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
//		query.whereEqualTo("playerName", "Dan Stemkoski");
		List<ParseObject> places = query.find();
		System.out.println("place size =============");
		System.out.println(places.size());
		System.out.println("=============");
		List<JSONObject> data = new ArrayList<JSONObject>();
		
		for (ParseObject parseObject : places) {
			data.add(parseObject.getParseData());
		}
		
		return data;
	}
}

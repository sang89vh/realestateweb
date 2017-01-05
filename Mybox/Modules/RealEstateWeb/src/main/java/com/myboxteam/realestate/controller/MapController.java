package com.myboxteam.realestate.controller;

import java.util.List;
import java.util.Map;

import org.parse4j.ParseException;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.parse4j.util.ParseRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.myboxteam.core.controller.MBBaseController;
import com.myboxteam.core.utils.MBUtils;
import com.myboxteam.realestate.model.RePlace;

@Controller
@SessionAttributes("map")
@RequestMapping("/map")
public class MapController extends MBBaseController {

	@RequestMapping(value = "/search-place", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> searchPlace()
			throws ParseException {

		ParseRegistry.registerSubclass(RePlace.class);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		// query.whereEqualTo("playerName", "Dan Stemkoski");
		List<ParseObject> places = query.find();
		System.out.println("place size =============");
		System.out.println(places.size());
		System.out.println("=============");

		return MBUtils.convertListParseToMap(places);

	}

	@RequestMapping(value = "/search-place2", method = RequestMethod.GET)
	public @ResponseBody List<Map<String, Object>> searchPlace3()
			throws ParseException {
		ParseObject gameScore = new ParseObject("RePlace");
		gameScore.put("title", "House parse1");
		ParseGeoPoint point = new ParseGeoPoint(21.040165999999998,
				105.79480189999999);
		gameScore.put("location", point);
		gameScore.save();

		ParseObject gameScore3 = new ParseObject("RePlace");
		gameScore3.put("title", "House parse2");
		ParseGeoPoint point3 = new ParseGeoPoint(21.020165999999998,
				105.77480189999999);
		gameScore3.put("location", point3);
		gameScore3.save();

		ParseRegistry.registerSubclass(RePlace.class);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		// query.whereEqualTo("playerName", "Dan Stemkoski");
		List<ParseObject> places = query.find();
		System.out.println("place size =============");
		System.out.println(places.size());
		System.out.println("=============");

		return MBUtils.convertListParseToMap(places);
	}
}

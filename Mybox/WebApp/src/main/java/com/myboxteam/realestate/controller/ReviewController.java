package com.myboxteam.realestate.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.parse4j.ParseException;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myboxteam.core.utils.MBUtils;

@Controller
@SessionAttributes("review")
@RequestMapping("/review")
public class ReviewController {

	@RequestMapping("/list")
	public ModelAndView property(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String proertyId = request.getParameter("property");
		return mav;
	}
	
	@RequestMapping(value = "/create")
	public @ResponseBody Map<String, Object> doCreate( HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "objId", required = true) String objId)
			throws ParseException {

		//logger.info(MBUtils.convertDateToPrettyTime(MBUtils.getCurrentDate()));
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(objId);
		return news.getData();
	}
}

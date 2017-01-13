package com.myboxteam.realestate.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("news")
@RequestMapping("/news")
public class NewsController {
	@RequestMapping("/{category}")
	public ModelAndView gird(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response,
			@PathVariable("category") String category) throws Exception {

		mav.setViewName("news/grid");
		return mav;
	}
	@RequestMapping("/property/{newUrl}")
	public ModelAndView property(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response,
			@PathVariable("newUrl") String newUrl) throws Exception {
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(newUrl);
		mav.addObject("news",news.getData());
		mav.setViewName("news/property");
		return mav;
	}
}

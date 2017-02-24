package com.myboxteam.realestate.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class BlankController {
	
	@RequestMapping("/")
	public ModelAndView doIndex(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response, 
			@RequestParam(value="search",required=false) String search,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="price",required=false) String price,
			@RequestParam(value="numBed",required=false) String numBed
			) throws Exception {
		if (search != null){
			mav.addObject("search", search);
		}
		if (type != null){
			mav.addObject("type", type);
		}
		if (price != null){
			mav.addObject("price", price);
		}
		if (numBed != null){
			mav.addObject("numBed", numBed);
		}
		mav.setViewName("home/index");
		return mav;
	}

}

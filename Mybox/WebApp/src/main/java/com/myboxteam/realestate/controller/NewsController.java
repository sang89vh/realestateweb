package com.myboxteam.realestate.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.parse4j.ParseException;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myboxteam.core.controller.MBBaseController;
import com.myboxteam.core.utils.MBUtils;
import com.myboxteam.core.utils.MapUtils;
import com.myboxteam.realestate.form.NewsForm;

@Controller
@SessionAttributes("news")
@RequestMapping("/news")
public class NewsController extends MBBaseController{
	
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
		
		logger.info(MBUtils.convertDateToPrettyTime(MBUtils.getCurrentDate()));
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(newUrl);
		
		Map<String,Object> data=news.getData();	
		Object formDate =data.get("fromDate");
		if(data !=null && !StringUtils.isEmpty(formDate)){
			String fdstr =MBUtils.convertDateToPrettyTime(formDate);
			data.put("fromDateLabel",fdstr);
		}
		
		mav.addObject("news",data);
		
		//search near by
		ParseGeoPoint lo = news.getParseGeoPoint("location");
		
		JSONArray placeNearHere = MapUtils.searchPlaceNear(lo);
		mav.addObject("placeNearHere",placeNearHere);
		
		mav.addObject("latitude",lo.getLatitude());
		mav.addObject("longitude",lo.getLongitude());
		
		mav.setViewName("news/property");
		return mav;
	}
	
	@RequestMapping("/dang-tin")
	public ModelAndView create(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		mav.setViewName("news/create");
		return mav;
	}
	
	@RequestMapping(value="/dang-tin",method=RequestMethod.POST)
	public @ResponseBody NewsForm save(@ModelAttribute("news") NewsForm news) throws Exception {
		
		return news;
	}
	
	@RequestMapping(value = "/uploadImages")
	public @ResponseBody Map<String,Object> upload(
			@RequestParam(value = "file", required = true) MultipartFile file) throws ParseException {
		String name = file.getOriginalFilename();
		String ext = FilenameUtils.getExtension(name);
		// generate output file
		String output = MBUtils.generateFileName(ext);

		// save file to storage
		MBUtils.saveFile(output, file);
		
		ParseObject image = new ParseObject("ReImages");
		image.put("path", output);
		image.save();
		
		return image.getData();
	}
	
	
}

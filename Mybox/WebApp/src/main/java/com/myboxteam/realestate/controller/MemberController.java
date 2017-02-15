package com.myboxteam.realestate.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.parse4j.ParseException;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myboxteam.core.utils.MBUtils;
import com.myboxteam.realestate.form.NewsForm;

@Controller
@SessionAttributes("member")
@RequestMapping("/member")
public class MemberController {

	@RequestMapping(value = "/management", method = RequestMethod.GET)
	public ModelAndView save(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		mav.setViewName("member/mamage-news");
		return mav;
	}

	@RequestMapping(value = "/create-news", method = RequestMethod.GET)
	public ModelAndView create(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		mav.setViewName("news/create");
		return mav;
	}

	@RequestMapping(value = "/create-news", method = RequestMethod.POST)
	public @ResponseBody Map save(@ModelAttribute("newsForm") NewsForm newsForm)
			throws Exception {

		newsForm.doValidate();

		ParseObject po = new ParseObject("ReNews");
		po.put("title", newsForm.getTitle());
		po.put("acreage", newsForm.getAcreage());
		po.put("address", newsForm.getAddress());
		po.put("content", newsForm.getContent());
		po.put("mobile", newsForm.getMobile());
		po.put("newType", newsForm.getNewType());
		po.put("price", newsForm.getPrice());
		po.put("priceUnit", newsForm.getPriceUnit());
		po.put("thumbs", newsForm.getImageIds());
		if (newsForm.getLagtidue() != null) {
			po.put("location", new ParseGeoPoint(newsForm.getLagtidue(),
					newsForm.getLongitude()));
		}
		po.save();

		return po.getData();
	}

	@RequestMapping(value = "/uploadImages")
	public @ResponseBody Map<String, Object> upload(
			@RequestParam(value = "file", required = true) MultipartFile file)
			throws ParseException {
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

package com.myboxteam.realestate.controller;

import java.util.Arrays;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myboxteam.core.controller.MBBaseController;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.parse4j.ParseException;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.myboxteam.core.config.MBConfig;
import com.myboxteam.core.utils.MBUtils;
import com.myboxteam.realestate.form.Comment;
import com.myboxteam.realestate.form.CommentWithFile;
import com.myboxteam.realestate.form.NewsForm;
import com.myboxteam.realestate.form.NewsQuery;


@Controller
@SessionAttributes("member")
@RequestMapping("/member")
public class MemberController extends MBBaseController{
	
	@Autowired
	private ObjectMapper mapper;
	private String[] offlineStatus = {"CLOSED","DELETED","EXPIRED"};
	
	
	@RequestMapping(value = "/manage-news", method = RequestMethod.GET)
	public ModelAndView manageNews(ModelAndView mav,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		mav.setViewName("member/mamage-news");
		return mav;
	}

	@RequestMapping(value = "getNews.ajax", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> getNews(
			HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("query") NewsQuery newsQuery) throws Exception {
		ParseQuery<ParseObject> query = ParseQuery.getQuery("ReNews");

		if (!StringUtils.isEmpty(newsQuery.getTitle())) {
			query.whereContains("title", newsQuery.getTitle());
		}
		if ("OFFLINE".equals(newsQuery.getStatus())) {
			
			query.whereContainedIn("status",Arrays.asList(offlineStatus));
			
		}else{
			
			query.whereEqualTo("status", newsQuery.getStatus());
		}
		

		query.skip(1);
		query.limit(50);
		List<ParseObject> places = query.find();

		return MBUtils.convertListParseToMap(places);
	}

	@RequestMapping(value = "/create-news", method = RequestMethod.GET)
	public ModelAndView create(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		mav.setViewName("news/create");
		return mav;
	}
	@RequestMapping(value = "/edit-news/{objectId}", method = RequestMethod.GET)
	public ModelAndView editNews(ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response,
			@PathVariable("objectId") String objectId
			) throws Exception {
		mav.addObject("objectId", objectId);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("ReNews");
		ParseObject data=query.get(objectId);
		Map map= data.getData();
		ParseGeoPoint location =(ParseGeoPoint)map.get("location");
		map.put("latitude", location.getLatitude());
		map.put("longitude", location.getLatitude());
		
		String newsJson = mapper.writeValueAsString(map);
		
		mav.addObject("newsJson", newsJson);
				
		mav.setViewName("news/edit");
		return mav;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/edit-news/{objectId}", method = RequestMethod.POST)
	public @ResponseBody Map edit(@PathVariable("objectId") String objectId,@ModelAttribute("newsForm") NewsForm newsForm)
			throws Exception {
		
		newsForm.doValidate();
		
		ParseQuery<ParseObject> query = ParseQuery.getQuery("ReNews");
		ParseObject po=query.get(objectId);
		po.put("title", newsForm.getTitle());
		po.put("acreage", newsForm.getAcreage());
		po.put("address", newsForm.getAddress());
		po.put("content", newsForm.getContent());
		po.put("mobile", newsForm.getMobile());
		po.put("newType", newsForm.getNewType());
		po.put("price", newsForm.getPrice());
		po.put("priceUnit", newsForm.getPriceUnit());
		po.put("thumbs", newsForm.getImageIds());
		if (newsForm.getLatitude() != null) {
			po.put("location", new ParseGeoPoint(newsForm.getLatitude(),
					newsForm.getLongitude()));
		}
		po.put("createdBy", MBUtils.getCurrentUser());
		
		// Create from system( if systemType equal "ROBOTIC" then it's crawler)
		po.put("systemType", "MANUAL");
		
		// WAITING_APPROVAL=>APPROVED=>REPORTED=>SPAM
		// =>CLOSED
		// =>DELETED
		// =>EXPIRED
		po.put("status", "WAITING_APPROVAL");
		po.save();
		
		Map map= po.getData();
		ParseGeoPoint location =(ParseGeoPoint)map.get("location");
		map.put("latitude", location.getLatitude());
		map.put("longitude", location.getLatitude());
		
		return map;
	}
	@SuppressWarnings("rawtypes")
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
		if (newsForm.getLatitude() != null) {
			po.put("location", new ParseGeoPoint(newsForm.getLatitude(),
					newsForm.getLongitude()));
		}
		po.put("createdBy", MBUtils.getCurrentUser());

		// Create from system( if systemType equal "ROBOTIC" then it's crawler)
		po.put("systemType", "MANUAL");

		// WAITING_APPROVAL=>APPROVED=>REPORTED=>SPAM
		// =>CLOSED
		// =>DELETED
		// =>EXPIRED
		po.put("status", "WAITING_APPROVAL");
		po.save();

		return po.getData();
	}

	@RequestMapping(value = "/uploadImages")
	public @ResponseBody Map<String, Object> upload(
			@RequestParam(value = "file", required = true) MultipartFile file)
			throws ParseException {

		ParseObject image = new ParseObject("ReImages");
		image.put("path", saveMultipartFile(file));
		image.save();

		return image.getData();
	}
	
	
	@ModelAttribute(value="SERVER_IMAGE")
	public String serverImage(){
		return MBConfig.SERVER_IMAGE;
	}

	@RequestMapping(value = "/add-comment")
	public @ResponseBody Map doAddComment(@RequestBody Comment comment)
			throws Exception {

		String objId = comment.getObjId();
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(objId);

		List comments;
		int maxCommentId = 0;
		if (news.get("comments") != null){
			comments = (ArrayList) news.get("comments");
			maxCommentId = (int) news.get("maxCommentId");
		} else {
			comments = new ArrayList();
		}

		Map commentData = comment.getData();
		maxCommentId++;
		commentData.put("id",maxCommentId);
		commentData.values().removeIf(Objects::isNull);

		comments.add(commentData);
		news.put("comments", comments);
		news.put("maxCommentId", maxCommentId);
		news.save();
		return comment.getData();
	}

	@RequestMapping(value = "/add-comment-with-file")
	public @ResponseBody Map doAddCommentWithFile(@ModelAttribute CommentWithFile commentWithFile)
			throws Exception {

		commentWithFile.setFile_url(serverImage() + "/" + saveMultipartFile(commentWithFile.getFile()));

		String objId = commentWithFile.getObjId();
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(objId);

		List comments;
		int maxCommentId = 0;
		if (news.get("comments") != null){
			comments = (ArrayList) news.get("comments");
			maxCommentId = (int) news.get("maxCommentId");
		} else {
			comments = new ArrayList();
		}
		commentWithFile.setFile(null);
		commentWithFile.setObjId(null);
		Map commentData = objectMapper.convertValue(commentWithFile, Map.class);

		maxCommentId++;
		commentData.put("id",maxCommentId);
		commentData.values().removeIf(Objects::isNull);

		comments.add(commentData);
		news.put("comments", comments);
		news.put("maxCommentId", maxCommentId);
		news.save();

		return commentData;
	}

	@RequestMapping(value = "/edit-comment")
	public @ResponseBody Map doEditComment(@RequestBody Comment comment)
			throws Exception {

		String objId = comment.getObjId();
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(objId);

		List comments = (ArrayList) news.get("comments");
		for (Object commentData: comments ){
			if (commentData instanceof Map){
				Map commentMap = (Map) commentData;
				if ((int) commentMap.get("id") == (int) comment.getData().get("id")){
					commentMap.keySet().removeAll(comment.getData().keySet());
					commentMap.putAll(comment.getData());
					commentMap.values().removeIf(Objects::isNull);
					break;
				}
			}
		}
		news.put("comments", comments);
		news.save();
		return comment.getData();
	}

	@RequestMapping(value = "/delete-comment")
	public @ResponseBody Map doDeleteComment(@RequestBody Comment comment)
			throws Exception {

		String objId = comment.getObjId();
		ParseQuery<ParseObject> query = ParseQuery.getQuery("RePlace");
		ParseObject news = query.get(objId);

		List comments = (ArrayList) news.get("comments");
		for (Object commentData: comments ){
			if (commentData instanceof Map){
				Map commentMap = (Map) commentData;
				if ((int) commentMap.get("id") == (int) comment.getData().get("id")){
					comments.remove(commentData);
					break;
				}
			}
		}
		news.put("comments", comments);
		news.save();
		return comment.getData();
	}

	private String saveMultipartFile(MultipartFile file){
		String name = file.getOriginalFilename();
		String ext = FilenameUtils.getExtension(name);
		// generate output file
		String output = MBUtils.generateFileName(ext);

		// save file to storage
		MBUtils.saveFile(output, file);
		return output;
	}
}

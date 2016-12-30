package com.myboxteam.core.controller;

import java.sql.SQLException;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.myboxteam.core.service.IMB0002Service;
import com.myboxteam.database.model.MB0002Model;

/**
 * Just only index, view,
 * 
 * @author jack
 *
 */
@Controller
@SessionAttributes("mb0002")
@RequestMapping("/mb0002")
public class MB0002Controller extends MBBaseController {

	private static final Logger logger = LogManager
			.getLogger(MB0002Controller.class);
	@Autowired
	private IMB0002Service mb0002Service;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mav, @ModelAttribute MB0002Model prm)
			throws SQLException {

		mav.setViewName("mb0002/mb000201");
		return mav;
	}
}

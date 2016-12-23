package com.re.realestate.controller;

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

import com.re.realestate.model.Re0002Model;
import com.re.realestate.service.IRe0002Service;

/**
 * Just only index, view,
 * 
 * @author jack
 *
 */
@Controller
@SessionAttributes("re0002")
@RequestMapping("/re0002")
public class Re0002Controller extends ReBaseController {

	private static final Logger logger = LogManager
			.getLogger(Re0002Controller.class);
	@Autowired
	private IRe0002Service re0002Service;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mav, @ModelAttribute Re0002Model prm)
			throws SQLException {

		mav.setViewName("re0002/re000201");
		return mav;
	}
}

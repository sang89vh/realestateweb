package com.myboxteam.core.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.parse4j.ParseException;
import org.parse4j.ParseUser;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.myboxteam.database.model.UserModel;

@Controller
@SessionAttributes("authen")
@RequestMapping("/authen")
public class MB0001Controller extends MBBaseController {

	private static final Logger logger = LogManager
			.getLogger(MB0001Controller.class);

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mav,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout

	) {

		if (error != null) {
			mav.addObject("error", "Invalid username and password!");
		}

		if (logout != null || error != null) {
			mav.setViewName("authen/login");
		} else {
			mav.setViewName("redirect:/");
		}

		return mav;
	}

	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);

			model.addObject("username", userDetail.getUsername());
			model.addObject("role", userDetail.getAuthorities());

		}

		model.setViewName("authen/403");
		return model;

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutPage(HttpServletRequest request,
			HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/authen/login?logout";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signup(ModelAndView mav) {

		mav.setViewName("authen/signup");

		return mav;
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public @ResponseBody Map saveUser(@ModelAttribute("userModel") UserModel userModel) throws ParseException {

		ParseUser user = new ParseUser();
		user.setUsername(userModel.getUsername());
		user.setPassword(userModel.getPassword());
		user.put("role", "ROLE_MEMBER");
		user.save();
		return user.getData();
	}
}

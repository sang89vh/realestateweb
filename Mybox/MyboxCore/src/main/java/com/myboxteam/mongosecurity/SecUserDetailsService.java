package com.myboxteam.mongosecurity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.parse4j.ParseException;
import org.parse4j.ParseQuery;
import org.parse4j.ParseUser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
public class SecUserDetailsService implements UserDetailsService {
	

	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		/*
		 * Here add user data layer fetching from the MongoDB. I have used
		 * userRepository
		 */
		
		ParseQuery<ParseUser> query = ParseQuery.getQuery(ParseUser.class);
		query.whereEqualTo("username", username);
		List<ParseUser> lpu=null;
		try {
			lpu = query.find();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if (lpu == null || lpu.size() == 0) {
			throw new UsernameNotFoundException(username);
		} else {
			ParseUser pu = lpu.get(0);
			
			List<SimpleGrantedAuthority> authorities = Arrays.asList(new SimpleGrantedAuthority(pu.getString("role")));
			User user = new User(username, pu.getPass(),authorities);
			UserDetails details = new SecUserDetails(user);
			return details;
		}
	}
	
	
}
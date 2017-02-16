package com.myboxteam.mongosecurity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

//@Configuration
//@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	SecUserDetailsService userDetailsService;

	@Autowired
	public void configAuthBuilder(AuthenticationManagerBuilder builder)
			throws Exception {
		builder.userDetailsService(userDetailsService);
	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth)
			throws Exception {
		auth.inMemoryAuthentication()
		.withUser("user").password("user").roles("MEMBER")
		.and().withUser("admin").password("admin").roles("ADMIN", "MEMBER");
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
				.antMatchers("/**").permitAll()
				.antMatchers("/thanh-vien/**").hasRole("MEMBER").anyRequest().authenticated()
				.antMatchers("/quan-tri/**").hasRole("ADMIN").anyRequest().authenticated()
				.and().formLogin()
					.loginPage("/xac-thuc/dang-nhap")
					.defaultSuccessUrl("/")
					.failureUrl("/xac-thuc/dang-nhap?error")
					.usernameParameter("USER_NAME")
					.passwordParameter("PASSWORD")
					.permitAll()
				.and().logout().logoutSuccessUrl("/xac-thuc/dang-nhap?logout").permitAll()
				.and().csrf();
		
		http.exceptionHandling().accessDeniedPage("/xac-thuc/403");
	}

}
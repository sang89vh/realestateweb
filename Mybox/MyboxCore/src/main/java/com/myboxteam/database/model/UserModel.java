package com.myboxteam.database.model;

import org.hibernate.validator.constraints.Length;

public class UserModel extends MBBaseModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8308053475577905577L;

	//@Pattern(regexp="^(\\+\\d{1,3}[- ]?)?\\d{10}$", message="validator.invalid_mobile")
	@Length(min=10, message="validator.invalid_mobile")
	private String username;
	
	@Length(min=8,message="validator.short_password")
	private String password;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}

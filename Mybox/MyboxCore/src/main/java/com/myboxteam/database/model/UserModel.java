package com.myboxteam.database.model;

public class UserModel extends MBBaseModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8308053475577905577L;

	private String username;
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

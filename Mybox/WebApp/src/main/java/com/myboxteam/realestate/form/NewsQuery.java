package com.myboxteam.realestate.form;

import com.myboxteam.database.model.MBBaseModel;

public class NewsQuery extends MBBaseModel{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2115489603323081160L;
	private String title;
	private String status;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}

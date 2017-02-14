package com.myboxteam.realestate.form;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

public class NewsForm  extends BaseForm{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8267993275478807478L;
	@NotNull
	@NotBlank
	@NotEmpty
	private String title;
	private String imageIds;
	
	@NotNull
	@NotBlank
	@NotEmpty
	private String newType;
	
	@NotNull
	private Long acreage;
	
	@NotNull
	private Long price;
	
	@NotNull
	@NotBlank
	@NotEmpty
	private String priceUnit;
	
	@NotNull
	@NotBlank
	@NotEmpty
	private String content;
	
	@NotNull
	@NotBlank
	@NotEmpty
	private String address;
	
	@NotNull
	@NotBlank
	@NotEmpty
	private String mobile;
	
	@NotNull
	private Long longitude;
	
	@NotNull
	private Long lagtidue;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getImageIds() {
		return imageIds;
	}
	public void setImageIds(String imageIds) {
		this.imageIds = imageIds;
	}
	public String getNewType() {
		return newType;
	}
	public void setNewType(String newType) {
		this.newType = newType;
	}
	public Long getAcreage() {
		return acreage;
	}
	public void setAcreage(Long acreage) {
		this.acreage = acreage;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public String getPriceUnit() {
		return priceUnit;
	}
	public void setPriceUnit(String priceUnit) {
		this.priceUnit = priceUnit;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Long getLongitude() {
		return longitude;
	}
	public void setLongitude(Long longitude) {
		this.longitude = longitude;
	}
	public Long getLagtidue() {
		return lagtidue;
	}
	public void setLagtidue(Long lagtidue) {
		this.lagtidue = lagtidue;
	}

}

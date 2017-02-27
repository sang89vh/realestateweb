package com.myboxteam.realestate.form;

public class GeoBox {
	private double southwestLatitude;
	private double southwestLongitude;
	private double northeastLatitude;
	private double northeastLongitude;
	
	private String type;
	private Integer numBed;
	private Long fromPrice;
	private Long toPrice;
	
	public double getSouthwestLatitude() {
		return southwestLatitude;
	}
	public void setSouthwestLatitude(double southwestLatitude) {
		this.southwestLatitude = southwestLatitude;
	}
	public double getSouthwestLongitude() {
		return southwestLongitude;
	}
	public void setSouthwestLongitude(double southwestLongitude) {
		this.southwestLongitude = southwestLongitude;
	}
	public double getNortheastLatitude() {
		return northeastLatitude;
	}
	public void setNortheastLatitude(double northeastLatitude) {
		this.northeastLatitude = northeastLatitude;
	}
	public double getNortheastLongitude() {
		return northeastLongitude;
	}
	public void setNortheastLongitude(double northeastLongitude) {
		this.northeastLongitude = northeastLongitude;
	}
	public String getType() {
		return type;
	}
	public void setType(String newType) {
		this.type = newType;
	}
	public Integer getNumBed() {
		return numBed;
	}
	public void setNumBed(Integer numBed) {
		this.numBed = numBed;
	}
	public Long getFromPrice() {
		return fromPrice;
	}
	public void setFromPrice(Long fromPrice) {
		this.fromPrice = fromPrice;
	}
	public Long getToPrice() {
		return toPrice;
	}
	public void setToPrice(Long toPrice) {
		this.toPrice = toPrice;
	}

}

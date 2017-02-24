package com.myboxteam.realestate.form;

public class GeoBox {
	private double southwestLatitude;
	private double southwestLongitude;
	private double northeastLatitude;
	private double northeastLongitude;
	
	private String type;
	//private String price;
	private String numBed;
	private String fromPrice;
	
	private String toPrice;
	
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
//	public String getPrice() {
//		return price;
//	}
//	public void setPrice(String price) {
//		this.price = price;
//	}
	public String getNumBed() {
		return numBed;
	}
	public void setNumBed(String beds) {
		this.numBed = beds;
	}
	
	public String getFromPrice() {
		return fromPrice;
	}
	public void setFromPrice(String fromPrice) {
		this.fromPrice = fromPrice;
	}
	public String getToPrice() {
		return toPrice;
	}
	public void setToPrice(String toPrice) {
		this.toPrice = toPrice;
	}
}

package com.myboxteam.realestate.form;

public class GeoBox {
	private double southwestLatitude;
	private double southwestLongitude;
	private double northeastLatitude;
	private double northeastLongitude;
	
	private String newType;
	private String price;
	private String beds;
	
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
	public String getNewType() {
		return newType;
	}
	public void setNewType(String newType) {
		this.newType = newType;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getBeds() {
		return beds;
	}
	public void setBeds(String beds) {
		this.beds = beds;
	}
	
	
}

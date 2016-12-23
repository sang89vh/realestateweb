package com.re.realestate.service;

import java.sql.SQLException;
import java.util.List;

import com.re.realestate.model.FF0002Model;

public interface IFF0002Service {
	public List<FF0002Model> getHistoricalPriceBySymbol(FF0002Model prm)
			throws SQLException ;
	
}

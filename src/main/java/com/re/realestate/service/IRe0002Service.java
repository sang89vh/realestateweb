package com.re.realestate.service;

import java.sql.SQLException;
import java.util.List;

import com.re.realestate.model.Re0002Model;

public interface IRe0002Service {
	public List<Re0002Model> getHistoricalPriceBySymbol(Re0002Model prm)
			throws SQLException ;
	
}

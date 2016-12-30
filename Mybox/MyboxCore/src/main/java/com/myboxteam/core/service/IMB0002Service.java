package com.myboxteam.core.service;

import java.sql.SQLException;
import java.util.List;

import com.myboxteam.database.model.MB0002Model;

public interface IMB0002Service {
	public List<MB0002Model> getHistoricalPriceBySymbol(MB0002Model prm)
			throws SQLException ;
	
}

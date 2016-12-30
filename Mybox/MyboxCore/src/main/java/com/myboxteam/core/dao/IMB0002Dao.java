package com.myboxteam.core.dao;

import java.sql.SQLException;
import java.util.List;

import com.myboxteam.database.model.MB0002Model;

public interface IMB0002Dao {
	public List<MB0002Model> getHistoricalPriceBySymbol(MB0002Model prm) throws SQLException;
	public void insertHistoricalPrice(MB0002Model prm) throws SQLException;
}

package com.re.realestate.dao;

import java.sql.SQLException;
import java.util.List;

import com.re.realestate.model.Re0002Model;

public interface IRe0002Dao {
	public List<Re0002Model> getHistoricalPriceBySymbol(Re0002Model prm) throws SQLException;
	public void insertHistoricalPrice(Re0002Model prm) throws SQLException;
}

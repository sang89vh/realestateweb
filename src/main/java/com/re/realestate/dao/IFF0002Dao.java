package com.re.realestate.dao;

import java.sql.SQLException;
import java.util.List;

import com.re.realestate.model.FF0002Model;

public interface IFF0002Dao {
	public List<FF0002Model> getHistoricalPriceBySymbol(FF0002Model prm) throws SQLException;
	public void insertHistoricalPrice(FF0002Model prm) throws SQLException;
}

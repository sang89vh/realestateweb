package com.re.realestate.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Component;

import com.re.realestate.dao.IRe0002Dao;
import com.re.realestate.model.Re0002Model;
@Component("Re0002DaoImpl")
public class Re0002DaoImpl extends ReBaseDao implements IRe0002Dao{

	protected Re0002DaoImpl() {
		super("re0002");
	}

	public List<Re0002Model> getHistoricalPriceBySymbol(Re0002Model prm)
			throws SQLException {
		return selectList("getHistoricalPriceBySymbol", prm);
	}

	public void insertHistoricalPrice(Re0002Model prm) throws SQLException {
		insert("insertHistoricalPrice", prm);
		
	}

}

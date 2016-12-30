package com.myboxteam.core.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Component;

import com.myboxteam.core.dao.IMB0002Dao;
import com.myboxteam.database.model.MB0002Model;
@Component("Mb0002DaoImpl")
public class MB0002DaoImpl extends MBBaseDao implements IMB0002Dao{

	protected MB0002DaoImpl() {
		super("mb0002");
	}

	public List<MB0002Model> getHistoricalPriceBySymbol(MB0002Model prm)
			throws SQLException {
		return selectList("getHistoricalPriceBySymbol", prm);
	}

	public void insertHistoricalPrice(MB0002Model prm) throws SQLException {
		insert("insertHistoricalPrice", prm);
		
	}

}

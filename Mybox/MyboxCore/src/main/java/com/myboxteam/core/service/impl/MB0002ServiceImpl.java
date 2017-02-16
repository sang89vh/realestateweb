package com.myboxteam.core.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myboxteam.core.dao.IMB0002Dao;
import com.myboxteam.core.service.IMB0002Service;
import com.myboxteam.database.model.MB0002Model;

@Service("Mb0002ServiceImpl")
public class MB0002ServiceImpl implements IMB0002Service {
	
	private static final Logger logger = LogManager.getLogger(MB0002ServiceImpl.class);
	
	@Autowired
	public IMB0002Dao mb0002Dao;

	@Transactional
	public List<MB0002Model> getHistoricalPriceBySymbol(MB0002Model prm)
			throws SQLException {
		return mb0002Dao.getHistoricalPriceBySymbol(prm);
	}

	


}

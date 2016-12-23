package com.re.realestate.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.re.realestate.dao.IRe0002Dao;
import com.re.realestate.model.Re0002Model;
import com.re.realestate.service.IRe0002Service;

@Service("Re0002ServiceImpl")
public class Re0002ServiceImpl implements IRe0002Service {
	
	private static final Logger logger = LogManager.getLogger(Re0002ServiceImpl.class);
	
	@Autowired
	public IRe0002Dao re0002Dao;

	@Transactional
	public List<Re0002Model> getHistoricalPriceBySymbol(Re0002Model prm)
			throws SQLException {
		return re0002Dao.getHistoricalPriceBySymbol(prm);
	}

	


}

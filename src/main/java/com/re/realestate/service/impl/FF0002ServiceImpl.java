package com.re.realestate.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.re.realestate.dao.IFF0002Dao;
import com.re.realestate.model.FF0002Model;
import com.re.realestate.service.IFF0002Service;

@Service("FF0002ServiceImpl")
public class FF0002ServiceImpl implements IFF0002Service {
	
	private static final Logger logger = LogManager.getLogger(FF0002ServiceImpl.class);
	
	@Autowired
	public IFF0002Dao ff0002Dao;

	@Transactional
	public List<FF0002Model> getHistoricalPriceBySymbol(FF0002Model prm)
			throws SQLException {
		return ff0002Dao.getHistoricalPriceBySymbol(prm);
	}

	


}

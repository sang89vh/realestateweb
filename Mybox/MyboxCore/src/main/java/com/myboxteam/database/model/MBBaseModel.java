package com.myboxteam.database.model;

import java.io.Serializable;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class MBBaseModel implements Serializable {
	private static final long serialVersionUID = 2292588341787241441L;
	protected Logger logger = LogManager.getLogger(MBBaseModel.class);
}

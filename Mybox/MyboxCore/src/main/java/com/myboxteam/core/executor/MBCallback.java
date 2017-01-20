package com.myboxteam.core.executor;

import com.myboxteam.core.exception.MBException;


public abstract class MBCallback<T> {
	

	abstract void internalDone(Void paramT, MBCmd instance,
			MBException dmsException);
	
}

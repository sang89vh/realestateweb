package com.myboxteam.core.executor;

import com.myboxteam.core.exception.MBException;


public abstract class MBCmdCallback extends MBCallback<Void> {
	
	public abstract void done(MBCmd instance, MBException mbException);
	
	@Override
	void internalDone(Void paramT,MBCmd instance, MBException mbException) {
		done(instance, mbException);
	}

}

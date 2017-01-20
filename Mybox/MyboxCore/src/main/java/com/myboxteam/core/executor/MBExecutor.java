package com.myboxteam.core.executor;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MBExecutor {
	
	private static ExecutorService executor;
	
	static {
		executor = Executors.newFixedThreadPool(20);
	}
	
	public static void runInBackground(Runnable runnable) {
		executor.execute(runnable);
	}
	
	public static ExecutorService getExecutor() {
		return executor;
	}

}

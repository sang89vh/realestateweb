package com.myboxteam.core.executor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Locale;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;

import com.myboxteam.core.exception.ErrorCodeEnumImpl;
import com.myboxteam.core.exception.MBException;

public class MBCmd  implements MessageSourceAware{
	private MessageSource messageSource;
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	private static final Logger logger = LogManager.getLogger(MBCmd.class);
	private MBCmd instance;
	private Boolean isLogging = false;
	private Locale mLocale = new Locale("en");
	private String name;
	private String input;
	private String output;
	private Object[] prm;
	
	public MBCmd(String name, Object[] prm) {
		instance = this;
		this.name = name;
		this.prm = prm;
	}
	
	public Boolean getIsLogging() {
		return isLogging;
	}

	public void setIsLogging(Boolean isLogging) {
		this.isLogging = isLogging;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Object[] getPrm() {
		return prm;
	}
	public void setPrm(Object[] prm) {
		this.prm = prm;
	}
	
	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public void runCmdInBackground(MBCmdCallback cmdBackground) {
		MBInBackgroundThread task = new MBInBackgroundThread(
				cmdBackground);
		MBExecutor.runInBackground(task);
	}
	
	class MBInBackgroundThread extends Thread {
		MBCmdCallback mMBCmdCallback;

		public MBInBackgroundThread(MBCmdCallback callback) {
			mMBCmdCallback = callback;
		}

		public void run() {
			MBException exception = null;
			try {
				runCmd();
			} catch (MBException e) {
				exception = e;
			}
			if (mMBCmdCallback != null) {
				mMBCmdCallback.done(instance, exception);
			}
		}

		public void runCmd() throws MBException {
			try {
				prm = ArrayUtils.add(prm, input);
				prm = ArrayUtils.add(prm, output);
				String cmd = messageSource.getMessage(name,prm, mLocale);
				System.out.println("run cmd");
			} catch (Exception e) {

				logger.error(e.getMessage(), e);
				throw new MBException(ErrorCodeEnumImpl.UNKNOWN_ERROR);
			}

		}
		
		private  void writeLogRuntimeCMD(InputStream stderr) throws IOException {

	        if(isLogging) {
	            InputStreamReader isr = new InputStreamReader(stderr);
	            BufferedReader br = new BufferedReader(isr);
	            String line = null;
	            logger.info("<=========CMDLog=================>");
	            while ((line = br.readLine()) != null) {
	                logger.info(line);
	            }
	            logger.info("</========CMDLog=================>");
	        }

	    }

		
	}
}

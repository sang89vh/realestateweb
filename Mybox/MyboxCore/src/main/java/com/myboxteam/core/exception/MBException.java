package com.myboxteam.core.exception;
import java.util.List;

public class MBException extends BaseException {
	
	private static final long serialVersionUID = 8823356956725033191L;

	public MBException(ErrorCodeEnum errorCodeEnum) {
		super();
		this.setErrorCode(errorCodeEnum);
	}
	
	public MBException(ErrorCodeEnum errorCodeEnum,List<FieldError> fieldErrors) {
		super();
		this.setErrorCode(errorCodeEnum);
		this.setFieldErrors(fieldErrors);
	}
	


}

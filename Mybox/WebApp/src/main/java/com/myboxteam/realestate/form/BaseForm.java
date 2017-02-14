package com.myboxteam.realestate.form;

import java.io.Serializable;
import java.util.Locale;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import javax.validation.metadata.ConstraintDescriptor;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.util.StringUtils;

import com.myboxteam.core.exception.ErrorCodeEnumImpl;
import com.myboxteam.core.exception.MBException;
public class BaseForm implements Serializable{

	private static final long serialVersionUID = 1961134350530282846L;
	protected static Validator validator;
	protected Locale locale; 
	public BaseForm() {
		ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
		validator = factory.getValidator();
	}
	
	public void doValidate() throws MBException {
		Set<ConstraintViolation<BaseForm>> cvs = validator.validate(this);

		if (cvs.size() > 0) {

			MBException wbex = new MBException(
					ErrorCodeEnumImpl.FORM_VALIDATE_ERROR);

			for (ConstraintViolation<BaseForm> cv : cvs) {
				Object[] prm = getMessageBundlePrm(cv);

				wbex.addFieldError(cv.getPropertyPath().toString(),
						cv.getMessage(), cv.getMessageTemplate(), prm);
			}

			throw wbex;
		}
	};
	
	protected Object[] getMessageBundlePrm(ConstraintViolation<?> cv) {
		Object[] prm = {};
		ConstraintDescriptor<?> ct = cv.getConstraintDescriptor();

		String min = String.valueOf(ct.getAttributes().get("min"));
		if (!StringUtils.isEmpty(min)) {
			prm = ArrayUtils.add(prm, min);
		}

		String max = String.valueOf(ct.getAttributes().get("max"));
		if (!StringUtils.isEmpty(max)) {
			prm = ArrayUtils.add(prm, max);
		}

		String value = String.valueOf(ct.getAttributes().get("value"));
		if (!StringUtils.isEmpty(value)) {
			prm = ArrayUtils.add(prm, value);
		}

		String regexp = String.valueOf(ct.getAttributes().get("regexp"));
		if (!StringUtils.isEmpty(regexp)) {
			prm = ArrayUtils.add(prm, regexp);
		}
		String integerPr = String.valueOf(ct.getAttributes().get("integer"));
		if (!StringUtils.isEmpty(integerPr)) {
			prm = ArrayUtils.add(prm, integerPr);
		}

		String fraction = String.valueOf(ct.getAttributes().get("fraction"));
		if (!StringUtils.isEmpty(fraction)) {
			prm = ArrayUtils.add(prm, fraction);
		}

		return prm;
	}
}

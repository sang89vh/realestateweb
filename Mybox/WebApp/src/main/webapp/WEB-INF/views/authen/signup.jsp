<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<link  href="${ctx}/resources/css/mb0001/mb000101.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var saveSignupCallback = function(form,data){
	console.log(data);
	window.location.href=ctx+"/authen/login?logout";
	
}

</script>
	<div class="div-login-container">

		<form name='loginForm' id="form-signup" class="form-signup"
			action="<c:url value='/authen/signup' />" method='POST' data-action="saveForm" data-callback="saveSignupCallback">
			<h5 class="form-signup-heading text-center"><spring:message code="page.signup.header"/></h5>
			<label for="username" class="sr-only"><spring:message code="account.username"/></label> 
			<span id="error.username" class="message_error"></span>
			<input style="margin-top: 10px;" type='text' 
				   name='username' 
				   id='username' 
				   class='form-control'
				   placeholder="<spring:message code="account.username"/>" 
				   required 
				   autofocus />
				
			<label for="password" class="sr-only"><spring:message code="account.password"/></label>
			<span id="error.password" class="message_error"></span>
			<input style="margin-top: 10px;" type='password' 
				   name='password'
				   id="password"
				   placeholder="<spring:message code="account.password"/>" 
				   required 
				   class="form-control"
				   />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			
			<button id="btn-signup-submit" 	data-loading-text="Loading..." onclick="submitForm(this)" class="btn btn-lg btn-primary btn-block" type="button" style="margin-top: 10px;"><spring:message code="menu.signup"/></button>
			<a class='btn btn-lg btn-info btn-block' href="<c:url value='/authen/login?logout' />" style="margin-top: 10px;"><spring:message code="menu.login"/></a>
		</form>
	</div>

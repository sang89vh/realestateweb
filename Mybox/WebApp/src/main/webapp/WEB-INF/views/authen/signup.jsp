<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<link  href="${ctx}/resources/css/mb0001/mb000101.css" rel="stylesheet" type="text/css" />

	<div class="div-login-container">

		<form name='loginForm' id="form-signup" class="form-signup"
			action="<c:url value='/authen/signup' />" method='POST'>
			<label for="inputEmail" class="sr-only">Địa chỉ email</label> 
			<input style="margin-top: 10px;" type='text' 
				   name='username' 
				   id='username' 
				   class='form-control'
				   placeholder="Địa chỉ email" 
				   required 
				   autofocus />
				
			<label for="inputpassword" class="sr-only">Mật khẩu</label> 
			<input style="margin-top: 10px;" type='password' 
				   name='password'
				   id="password"
				   placeholder="Mật khẩu" 
				   required 
				   class="form-control"
				   />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			
			<button id="btn-signup-submit" 	data-loading-text="Loading..." class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top: 10px;">Đăng nhập</button>

		</form>
	</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<link  href="${ctx}/resources/css/mb0001/mb000101.css" rel="stylesheet" type="text/css" />

	<div class="div-login-container">

		

		<form name='loginForm' id="form-signup" class="form-signup"
			action="<c:url value='/login' />" method='POST'>
			<div >
				<c:if test="${not empty error}">
					<div class="error" style="text-align: center;">${error}</div>
				</c:if>
				<c:if test="${not empty msg}">
					<div class="msg" style="text-align: center;">${msg}</div>
				</c:if>
			</div>
			<h5 class="form-signup-heading text-center">Đăng nhập Webtimnha.com</h5>
			<label for="inputEmail" class="sr-only">Địa chỉ email</label> 
			<input style="margin-top: 10px;" type='text' 
				   name='USER_NAME' 
				   id='USER_NAME' 
				   class='form-control'
				   placeholder="Địa chỉ email" 
				   required 
				   autofocus />
				
			<label for="inputPassword" class="sr-only">Mật khẩu</label> 
			<input style="margin-top: 10px;" type='PASSWORD' 
				   name='PASSWORD'
				   id="inputPassword"
				   placeholder="Mật khẩu" 
				   required 
				   class="form-control"
				   />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			
			<button id="btn-signup-submit" 	data-loading-text="Loading..." class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top: 10px;">Đăng nhập</button>

		</form>
	</div>

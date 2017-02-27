<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<link  href="${ctx}/resources/css/mb0001/mb000101.css" rel="stylesheet" type="text/css" />
	<div class="div-login-container">
		<form name='loginForm' id="form-signup" class="form-signup" action="<c:url value='/login' />" method='POST'>
			<div >
				<c:if test="${not empty error}">
					<script type="text/javascript">
						sweetAlert("Oops...", "${error}", "error");
					</script>
				</c:if>
				<c:if test="${not empty msg}">
					<script type="text/javascript">
						sweetAlert("${msg}");
					</script>
				</c:if>
			</div>
			<h5 class="form-signup-heading text-center"><spring:message code="page.login.header"/></h5>
			<label for="USER_NAME" class="sr-only"><spring:message code="account.username"/></label> 
			<input style="margin-top: 10px;" type='text' 
				   name='USER_NAME' 
				   id='USER_NAME' 
				   class='form-control'
				   placeholder="<spring:message code="account.username"/>" 
				   required 
				   autofocus />
				
			<label for="PASSWORD" class="sr-only"><spring:message code="account.password"/></label> 
			<input style="margin-top: 10px;" type='PASSWORD' 
				   name='PASSWORD'
				   id="PASSWORD"
				   placeholder="<spring:message code="account.password"/>" 
				   required 
				   class="form-control"
				   />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			
			<button id="btn-signup-submit" 	data-loading-text="Loading..." class="btn btn-lg btn-primary btn-block" type="submit" style="margin-top: 10px;"><spring:message code="menu.login"/></button>
			<a  href="<c:url value='/authen/signup' />" style="margin-top: 10px;"><spring:message code="menu.signup"/></a>
		</form>
	</div>

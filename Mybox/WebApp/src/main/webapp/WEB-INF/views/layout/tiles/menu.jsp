<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<nav class="navbar navbar-inverse navbar-embossed" role="navigation">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#navbar-collapse-01">
			<span class="sr-only">Trang chủ</span>
		</button>
		<a class="navbar-brand" href="${ctx}/">Trang chủ</a>
	</div>
	<div class="collapse navbar-collapse" id="navbar-collapse-01">
		<ul class="nav navbar-nav navbar-left realestate-nav-left">
			<li><a href="${ctx}/">Bán</a></li>
			<li><a href="${ctx}/">Cho thuê</a></li>
			<li><a href="${ctx}/">Dự án</a></li>
			<li><a href="${ctx}/">Chủ đầu tư</a></li>
			<li><a href="${ctx}/">Môi giới uy tín</a></li>
			
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li>
				<a href="#" onclick="changeLanguage('vn')" style="float: left;">
					<img alt="Tiếng Việt" src="${ctx}/resources/img/Vietnam.png" style="width: 25px;height: 25px;">
				</a>
				<a href="#" onclick="changeLanguage('en')" style="float: left;">
					<img alt="English" src="${ctx}/resources/img/United_Kingdom.png" style="width: 25px;height: 25px;">
				</a>
			</li>
			<sec:authorize access="hasRole('MEMBER')">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="menu.account"/><b class="caret"></b></a> 
						<span class="dropdown-arrow"></span>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/authen/logout' />"><spring:message code="menu.logout"/></a></li>
					</ul>
				</li>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="menu.signup"/>/<spring:message code="menu.login"/><b class="caret"></b></a> 
						<span class="dropdown-arrow"></span>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/authen/login?logout' />"><spring:message code="menu.login"/></a></li>
						<li><a href="<c:url value='/authen/signup' />"><spring:message code="menu.signup"/></a></li>
					</ul>
				</li>
			</sec:authorize>	
		</ul>
	</div>
	<!-- /.navbar-collapse -->
</nav>
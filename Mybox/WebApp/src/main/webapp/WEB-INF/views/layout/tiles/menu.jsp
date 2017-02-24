<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<nav class="navbar navbar-inverse navbar-embossed" role="navigation">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#navbar-collapse-01">
			<span class="sr-only"><spring:message code="menu.home"/></span>
		</button>
		<a class="navbar-brand" href="${ctx}/"><spring:message code="menu.home"/></a>
	</div>
	<div class="collapse navbar-collapse" id="navbar-collapse-01">
		<ul class="nav navbar-nav navbar-left realestate-nav-left">
			<li><a href="${ctx}/"><spring:message code="menu.for_rent"/></a></li>
			<li><a href="${ctx}/best-hosts"><spring:message code="menu.best_host"/></a></li>
			<li><a href="${ctx}/contact"><spring:message code="menu.contact"/></a></li>
			<li><a href="${ctx}/help"><spring:message code="menu.help"/></a></li>
			
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
				<li>
					<a  href="<c:url value='/member/create-news' />"><spring:message code="menu.create_news"/></a>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><spring:message code="menu.account"/><b class="caret"></b></a> 
						<span class="dropdown-arrow"></span>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/member/profile' />"><spring:message code="menu.profile"/></a></li>
						<li><a href="<c:url value='/authen/logout' />"><spring:message code="menu.logout"/></a></li>
					</ul>
				</li>
			</sec:authorize>
			<sec:authorize access="isAnonymous()">
				<li>
					<a  href="<c:url value='/authen/login?logout=&goUrl=/member/create-news' />"><spring:message code="menu.create_news"/></a>
				</li>
			</sec:authorize>	
		</ul>
	</div>
	<!-- /.navbar-collapse -->
</nav>
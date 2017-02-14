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
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản<b class="caret"></b></a> 
					<span class="dropdown-arrow"></span>
				<ul class="dropdown-menu">
					<li><a href="<c:url value='/xac-thuc/dang-xuat' />">Đăng xuất</a></li>
				</ul></li>
		</ul>
	</div>
	<!-- /.navbar-collapse -->
</nav>
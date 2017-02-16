<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="tiles/header.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<tiles:insertAttribute name="body" />
			</div>
			<div class="col-md-4"></div>

		</div>
	</div>
</body>
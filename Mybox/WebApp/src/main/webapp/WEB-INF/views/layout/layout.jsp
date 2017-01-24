<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<%@page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="tiles/header.jsp"></jsp:include>
</head>
<body>
	<div class="row">
			<tiles:insertAttribute name="menu" />
	</div>
	<div class="row">
		<div class="form-group">
        	<div class="input-group">
            	<input class="form-control" id="search-location-text" type="search" placeholder='Tim dia diem' value='${search}'>
            	<span class="input-group-btn">
                	<!-- <button type="submit" class="btn" id="search-within-time"><span class="fui-search"></span></button>  -->
                	<button class="btn" id="search-location"><span class="fui-search"></span></button>
                </span>
        	</div>
        </div>
	</div>
<!-- 	<div class="container bs-docs-container"> -->
	<div >
		<div class="col-md-12">
		<div class="row">
			<div id="script-warning" class=""></div>
		</div>
			<tiles:insertAttribute name="body" />
		</div>
	</div>
</body>
<footer>
<%-- 	<tiles:insertAttribute name="footer" /> --%>
</footer>




<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<%@page session="true"%>
    <style>

      #map {
        height: 100%;
      }
    </style>
	<div class="row">
		<%@ include file="/WEB-INF/views/common/search_realestate.jsp" %>
	</div>
	<div class="row" >
		<div class="col-md-5 news-container" style="height: 500px;overflow-y: scroll;">
			<div class="row" id="new-row"></div>
		</div>
    	<div class="col-md-7 map">
    		<div id="map" class="col-md-7" style="width:100%;height: 100%"></div>
    	</div>
    </div>
    <div id="temp-row" style="display: none;">
		<div class="item well">
			<a href="#">
				<img alt="" src="" style="width: 100%;height: auto;">
			</a>
			<b class="price" ></b><br/>
			<span class="info"></span><br/>
			<span class="address"></span><br/>
		</div>
	</div>

<%@ include file="/WEB-INF/views/common/select_location.jsp" %>


    <script type="text/javascript" src="${ctx}/resources/js_dev/webapp/home/index.js"></script>

	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>

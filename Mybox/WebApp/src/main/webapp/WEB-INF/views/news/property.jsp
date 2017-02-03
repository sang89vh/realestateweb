<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
  <style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  </style>
<script type="text/javascript">
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	//var c = ${news};
	var lat = ${latitude};
	var lng = ${longitude};
	var targetPos = {
		lat: lat,
	    lng: lng
    };
	map.setCenter(targetPos);
	
	var iconTargetPos = {
			  url: ctx + "/resources/img/icons/map/selectedHousePos.ico", // url
			  scaledSize: new google.maps.Size(40,40), // scaled size
			  origin: new google.maps.Point(0,0), // origin
			  anchor: new google.maps.Point(0, 0), // anchor
			};
	
	var markerTargetPos = new google.maps.Marker({
	 	map: map,
        position: {lat: lat, lng:lng},
        //title: obj.title,
		icon: iconTargetPos,
        //id: news.objectId,
        //infowindow: placeInfoWindow,
        //label: "Marker A"
      });
	
	var baseLat = ${baseLat};
	var baseLng = ${baseLng};
	var markerBasePos = new google.maps.Marker({
		map: map,
        position: {lat: baseLat, lng: baseLng},
	});
	console.log(lat);
}
var searchLocations = function(){
	var locationAutocomplete = new google.maps.places.Autocomplete(document.getElementById('search-location-text'));
	var searchAddress =  document.getElementById('search-location-text');
	var searchBox = new google.maps.places.SearchBox(searchAddress);
	
	searchBox.addListener('places_changed', function() {
		var url = ctx + '?search=' + encodeURIComponent($("#search-location-text").val());
		var link = document.createElement('a');
		link.href = url;
		document.body.appendChild(link);
		link.click();
	});
	
}
var drawGrid = function(obj) {

	$("#jsGrid")
			.jsGrid(
					{
						height : "auto",
						width : "100%",

						filtering : false,
						editing : false,
						sorting : true,
						paging : true,
						autoload : true,

						pageSize : 15,
						pageButtonCount : 5,
						rowClick : function(row) {
							console.log(row.item);
							location.href=ctx+"/news/property/"+row.item.objectId
						},
						deleteConfirm : "Do you really want to delete the client?",

						controller : {
							loadData : function() {
								var d = $.Deferred();

								$.ajax(
												{
													url : ctx + "/map/search-place",
													dataType : "json",
													method : 'post',
													data : obj
												}).done(function(response) {
											d.resolve(response);
										});

								return d.promise();
							}
						},

						fields : [
						           {
										name : "title",
										title : "Tiêu đề",
										type : "text"
									},
									{
										name : "acreage",
										title : "Diện tích",
										type : "text"
										
									},
									{
										name : "price",
										title : "Giá",
										type : "text"
										
									}
						          ]
					});

};
/*
$(document).ready(function(){
	var prm ={
		southwestLatitude : 21.027684827936138,
		southwestLongitude : 105.77814722164305,
		northeastLatitude : 21.032691930005605,
		northeastLongitude : 105.79145097835692

	};
	drawGrid(prm);


})
*/
$(document).ready(function() {
	searchLocations();
});
</script>
<div class="row">
	<div class="col-md-4">
		<div class="bs-example" data-example-id="text-form-control">
			<div class="col-md-12"
				style="background-color: #474e52; color: white;">
				<h6>${news.price}</h6>
			</div>
			<div class="col-md-12" style="margin-top: 10px">
				<form>
					<input class="form-control" placeholder="Tên"><br /> <input
						class="form-control" placeholder="Điện thoại"><br /> <input
						class="form-control" placeholder="Email"><br />
					<textarea class="form-control" rows="5">Tôi muốn được tư vấn thêm về: ${news.title}</textarea>
					<br />
					<button type="button" class="btn btn-primary" style="width: 100%">Tư
						vấn thêm cho tôi</button>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-8">
		<div class="row" style="height: 400px!important;">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					 <ol class="carousel-indicators">
						<c:forEach var="imgUrl" items="${news.thumbs}" varStatus="loop">
							<li data-target="#myCarousel" data-slide-to="${loop.index}" class='${loop.index==0?"active":""}'></li>
						</c:forEach>
					 </ol>
				 <!-- Wrapper for slides -->
			    <div class="carousel-inner" role="listbox">
			    
			    <c:forEach var="imgUrl" items="${news.thumbs}" varStatus="loop">
			      <div class='item ${loop.index==0?"active":""}'>
			        <img src="${imgUrl.replace("200x200", "745x510")}" height="400px" style="height: 400px!important">
			      </div>
				</c:forEach>
			    
			    </div>
			
			    <!-- Left and right controls -->
			    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			      <span class="sr-only">Previous</span>
			    </a>
			    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			      <span class="sr-only">Next</span>
			    </a>
		  	</div>
	  	</div>
	  	<div class="row">
			<table class="table">
				<h6>${news.title}</h6>
				<tbody>
				<c:if test="${news.acreage!=null or news.price!=null }">
					<tr>
						<th >Diện tích</th>
						<td>${news.acreage}</td>
						<td>Giá</td>
						<td>${news.price}</td>
					</tr>
				</c:if>
				<c:if test="${news.toilet!=null or news.kitchen!=null}">
					<tr>
						<th >Nhà vệ sinh</th>
						<td>${news.toilet}</td>
						<td>Bếp</td>
						<td>${news.kitchen}</td>
					</tr>
				</c:if>
				<c:if test="${ (not empty news.kitchen) or (not empty news.dryingYard) }">
					<tr>
						<th >Sân phơi</th>
						<td>${news.kitchen}</td>
						<td>Phòng khách</td>
						<td>${news.dryingYard}</td>
					</tr>
				</c:if>
				<c:if test="${ (not empty news.direction) or (not empty news.bedRoom) }">
					<tr>
						<th >Hướng nhà</th>
						<td>${news.direction}</td>
						<td>Phòng ngủ</td>
						<td>${news.bedRoom}</td>
					</tr>
				</c:if>
				<c:if test="${ (not empty news.startDateLabel) or (not empty news.endDate)}">
					<tr>
						<th >Ngày đăng tin</th>
						<td>${news.startDateLabel}</td>
						<td>Hết hạn</td>
						<td>${news.endDate}</td>
					</tr>
				</c:if>
				</tbody>
			</table>
	</div>
	</div>
</div>
<div>		
	<div class="col-md-12">
		<p>${news.content}</p>
	</div>
	<div class="col-md-12">
		<h6>Tiện ích xung quanh</h6>	
		<div class="col-md-6" style="    height: 420px;overflow-y: scroll;">
				<table class="table">
					<caption>Địa điểm</caption>
					<tbody>
						<c:forEach begin="0" end="${placeNearHere.length() -1}" var="index">
				     		<c:set var="place" value="${placeNearHere.getJSONObject(index)}"></c:set>
								<tr>
									<td><img alt="" src="${place.getString("icon") }"    style="width: 20px;height: 20px;"></td>
									<td>${place.getString("name") }</td>
									<td>${place.getString("vicinity") }</td>
								</tr>
							</c:forEach>
					</tbody>
				</table>
			
		</div>
		<div class="col-md-6 map">
    		<div id="map" class="col-md-7" style="width:100%;height: 100%"></div>
		</div>
	</div>
	<div class="col-md-12">
		<h6>Một số bất động sản lân cận</h6>
		<div class="col-md-12">
				<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="1200" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		</div>
		<h6>So sánh</h6>
		<div class="col-md-12">
			<div id="jsGrid"></div>
		</div>
	</div>
</div>
	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>
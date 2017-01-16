<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<script type="text/javascript">

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
							
							buildForm(row.item);
							searchYts(row.item.title);
							 $("#status_action").html("doing");
							video =row.item;
							

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
$(document).ready(function(){
	var prm ={
		southwestLatitude : 21.027684827936138,
		southwestLongitude : 105.77814722164305,
		northeastLatitude : 21.032691930005605,
		northeastLongitude : 105.79145097835692

	};
	drawGrid(prm);
	
})
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
		<div class="row"
			style="height: 350px;background-image: url(${news.thumbs[0]});background-repeat: no-repeat;background-size:cover">
			<div class="row" style="height: 300px">
				<div style="display: none;">
					<c:forEach var="imgUrl" items="${news.thumbs}">
						<a class="fffancybox" rel="fancybox-button" href="${imgUrl}"><img
							src="${imgUrl}" alt="" /></a>
					</c:forEach>
				</div>
			</div>
			<div class="row" style="height: 50px">
				<div class="col-md-10"></div>
				<div class="col-md-1">
					<a class="fffancybox" rel="group1"> <img alt=""
						src="${ctx}/resources/img/home.jpg" class="img-thumbnail">
					</a>
				</div>
				<div class="col-md-1">
					<a> <img alt=""
						src="${ctx}/resources/img/map_icon_70x70_txl2.png"
						class="img-thumbnail">
					</a>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="table">
				<caption>${news.title}</caption>
				<tbody>
					<tr>
						<th >Diện tích</th>
						<td>${news.acreage}</td>
						<td>Giá</td>
						<td>${news.price}</td>
					</tr>
					<tr>
						<th >Nhà vệ sinh</th>
						<td>${news.toilet}</td>
						<td>Bếp</td>
						<td>${news.kitchen}</td>
					</tr>
					<tr>
						<th >Sân phơi</th>
						<td>${news.kitchen}</td>
						<td>Phòng khách</td>
						<td>${news.dryingYard}</td>
					</tr>
					<tr>
						<th >Hướng nhà</th>
						<td></td>
						<td>Phòng ngủ</td>
						<td>${news.bedRoom}</td>
					</tr>
					<tr>
						<th >Ngày đăng tin</th>
						<td>${news.startDateLabel}</td>
						<td>Hết hạn</td>
						<td>${news.endDate}</td>
					</tr>
					
				</tbody>
			</table>

		</div>
		
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
		<div class="col-md-6">
			<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
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
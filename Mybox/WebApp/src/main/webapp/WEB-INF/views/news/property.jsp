<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
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
						<td>Phòng ngủ</td>
						<td>2</td>
					</tr>
					<tr>
						<th >Nhà vệ sinh</th>
						<td>2</td>
						<td>Bếp</td>
						<td>1</td>
					</tr>
					<tr>
						<th >Sân phơi</th>
						<td>1</td>
						<td>Phòng khách</td>
						<td>1</td>
					</tr>
					<tr>
						<th >Đăng 10 Ngày trước </th>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>

		</div>
		
	</div>
	<div class="col-md-12">
		<h6>Tiện ích xung quanh</h6>	
		<div class="col-md-6">
			<h6>Giao thông</h6>
			<table class="table">
				<caption>Địa điểm ăn uống</caption>
				<tbody>
					<tr>
						<td>Món huế 24 Trần nhân tông</td>
					</tr>
					<tr>
						<th >Bún chả 40 Trần Quốc Hoàn</th>
					</tr>
					<tr>
						<th >Bánh mỳ kep - 50 Nghĩa Tân</th>
					</tr>
				</tbody>
			</table>
			<h6>Khu mua sắm</h6>
			<h6>Trường học</h6>
		</div>
		<div class="col-md-6">
			<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-md-12">
		<div class="col-md-6">
				<table class="table">
					<caption>${news.price}</caption>
					<tbody>
						<tr>
							<td>Giá nhà</td>
							<td>10 triệu</td>
						</tr>
						<tr>
							<td >Phí internet</td>
							<td >500 nghìn</td>
						</tr>
						<tr>
							<td >Tiền nước</td>
							<td >5 nghìn/1 số</td>
						</tr>
					</tbody>
				</table>
		</div>
		<div class="col-md-6">
		</div>
	</div>
	<div class="col-md-12">
		<div class="col-md-12">
				<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="1200" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		</div>
	</div>
	<div class="col-md-12">
		<h6>Bất động sản có thể bạn quan tâm</h6>
		<div class="col-md-12">
			<%@ include file="/WEB-INF/views/news/grid.jsp"%>
		</div>
	</div>
</div>
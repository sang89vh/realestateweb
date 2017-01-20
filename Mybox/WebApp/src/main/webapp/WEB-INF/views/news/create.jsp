<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<style type="text/css">
#form-create input,select,textarea {
	margin-bottom: 10px;
}

</style>
<div class="row">
	<div class="col-md-12" id="form-create"  style="margin-top: 10px">
				<form>
					<div class="col-md-12" style="background-color: #474e52; color: white;margin-bottom: 10px;">
						<h6>Thông tin nhà đất</h6>
					</div>
					
					<div class="row" style="margin-top: 10px">
						<div class="col-md-9">
							<input class="form-control" placeholder="Tiêu đề tin"> 
						</div>
						<div class="col-md-3">
							<select class="selectpicker" style="width: 100%">
							  <option>Phân loại</option>
							  <option>Bán căn hộ chung chư</option>
							  <option>Bán nhà riêng</option>
							  <option>Bán nhà biệt thự liền kề</option>
							  <option>Bán nhà mặt phố</option>
							  <option>Bán đất nền dự án</option>
							  <option>Bán đất</option>
							  <option>Bán trang trại, khu nghỉ dưỡng</option>
							  <option>Bán kho, nhà xưởng</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<input class="form-control" placeholder="Điện tích(m²)">
						</div>
						<div class="col-md-3">
							<input class="form-control" placeholder="Giá">
						</div>
						<div class="col-md-3">
							<select class="selectpicker">
							  <option>Đơn vị</option>
							  <option>Triệu</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<textarea class="form-control" rows="5"></textarea>
							<input class="form-control" placeholder="Điện thoại liên hệ">
							<div class="">
								<h6>Hình ảnh nhà đất</h6>
							</div>
							<div class="" style="margin-top: 10px">
								<div style="border: dotted 2px;width: 100px;height: 100px">
									<span style="text-align: center">Ảnh nhà đất</span>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<input class="form-control" placeholder="Địa chỉ" style="margin-top: 10px"> 
							<div class="col-md-12">
								<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="600" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
							</div>
						</div>
					</div>
					<div class="" style="margin-top: 10px">
						<button type="button" class="btn btn-primary" style="width: 200px">Đăng tin</button>
					</div>
					
				</form>
	</div>
</div>
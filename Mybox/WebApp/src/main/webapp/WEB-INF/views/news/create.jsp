<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<style type="text/css">
#form-create input,select,textarea {
	margin-bottom: 10px;
}

</style>
<div class="row">
	<div class="col-md-12" id="form-create"  style="margin-top: 10px">
				<form  id="form-create-news" action="${ctx}/member/create-news" method="post" data-action="saveForm" data-callback="saveNewsCallback">
					<div class="col-md-12" style="background-color: #474e52; color: white;margin-bottom: 10px;">
						<div class="col-md-6">
							<h6>Thông tin nhà đất</h6>
						</div>
						<div class="col-md-6">
							<button type="button" class="btn btn-primary" style="float: right;margin: 10px" onclick="preSubmitForm(this)">Đăng tin</button>
						</div>
					</div>
					
					<div class="row" style="margin-top: 10px">
						<div class="col-md-9">
							<span id="error.title" class="message_error"></span>
							<input id="title" name="title" class="form-control" placeholder="Tiêu đề tin" type="text" min="5" maxlength="400" autocomplete="on" autofocus="autofocus" required="required"> 
						</div>
						<div class="col-md-3">
							<span id="error.newType" class="message_error"></span>
							<select id="newType" name ="newType"  class="selectpicker" style="width: 100%">
							  <option value=""><spring:message code="NEWS_CATEGORY"/></option>
							  <option value="FOR_RENT_APARTMENT"><spring:message code="FOR_RENT_APARTMENT"/></option>
							  <option value="FOR_RENT_HOUSE"><spring:message code="FOR_RENT_HOUSE"/></option>
							  <option value="FOR_RENT_HOTEL"><spring:message code="FOR_RENT_HOTEL"/></option>
							  <option value="FOR_RENT_HOSTEL"><spring:message code="FOR_RENT_HOSTEL"/></option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<span id="error.acreage" class="message_error"></span>
							<input id="acreage" name="acreage" type="number" min="0" required="required" class="form-control" placeholder="Điện tích(m²)">
						</div>
						<div class="col-md-3">
							<span id="error.price" class="message_error"></span>
							<input id="price" name="price" type="number" min="0" required="required" class="form-control" placeholder="Giá">
						</div>
						<div class="col-md-3">
							<span id="error.priceUnit" class="message_error"></span>
							<select id="priceUnit" name="priceUnit"  class="selectpicker" required="required">
							  <option value=""><spring:message code="PRICE_UNIT"/></option>
							  <option value="USD_PER_MONTH"><spring:message code="USD_PER_MONTH"/></option>
							  <option value="VND_MILLION_PER_MONTH"><spring:message code="VND_MILLION_PER_MONTH"/></option>
							  <option value="VND_HUNDERD_PER_MONTH"><spring:message code="VND_VND_HUNDERD_PER_MONTH"/></option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<span id="error.content" class="message_error"></span>
							<textarea id="content" name="content"  required="required"  class="form-control" rows="9"></textarea>
							
							<span id="error.mobile" class="message_error"></span>
							<input id="mobile" name="mobile" type="number" required="required"  class="form-control" placeholder="Điện thoại liên hệ">
							<div class="images">
								<input id="imageIds" name="imageIds" type="text" hidden="true" >
								<h6>Hình ảnh nhà đất</h6>
								<span id="error.imageIds" class="message_error"></span>
							</div>
							<div class="drop-images" style="margin-top: 10px" id="my-dropzone">
								<p>Kéo ảnh nhà đất vào ô này</p>
								 <div class="fallback">
								    <input name="file" type="file" multiple />
								  </div>
							</div>
						</div>
						<div class="col-md-6">

							
							<input name="latitude" type="number" hidden="true" value="21.0309421">
							<input name="longitude" type="number" hidden="true" value="105.7839107">


							<h6>Địa chỉ</h6>
							<div class="row">	
            					<input class="form-control" id="search-location-text" type="search" placeholder='Tim dia diem' value='${search}'>
							</div>
          					<div class="map">         					
    							<div id="map" style="width:100%;height: 100%"></div>
    						</div>
          					<div id="posDetail">
           						<label>Địa chỉ được chọn</label>
           						<p/>
           						<input id="address" name="address" class="form-control" placeholder="Số nhà, ngõ, đường" type="text" min="5" maxlength="400" autocomplete="on" autofocus="autofocus" required="required"> 
           						<div id="posAdminDetail">
           						</div>
           						<div id="posLatLng">
           						</div>
           					</div>
							<!-- <input name="address" required="required" class="form-control" placeholder="Địa chỉ" style="margin-top: 10px">  -->
							<!-- 

							<div class="col-md-12">
								<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d14896.52466399664!2d105.82315895!3d21.0274371!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1484299700561" width="600" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
							</div>
							 -->
						</div>
					</div>
					<div class="" style="margin-top: 10px">
						<button type="button" class="btn btn-primary" style="float: right;margin: 10px" onclick="preSubmitForm(this)">Đăng tin</button>
					</div>
					
				</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/select_location.jsp" %>

<script type="text/javascript"  src="${ctx}/resources/js/webapp/news/create.js"></script>

	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>


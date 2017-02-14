<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<style type="text/css">
#form-create input,select,textarea {
	margin-bottom: 10px;
}

</style>
<div class="row">
	<div class="col-md-12" id="form-create"  style="margin-top: 10px">
				<form  id="form-create-news" action="${ctx}/news/dang-tin" method="post" data-action="saveForm" data-callback="saveNewsCallback">
					<div class="col-md-12" style="background-color: #474e52; color: white;margin-bottom: 10px;">
						<h6>Thông tin nhà đất</h6>
					</div>
					
					<div class="row" style="margin-top: 10px">
						<div class="col-md-9">
							<span id="error.title" class="message_error"></span>
							<input id="title" name="title" class="form-control" placeholder="Tiêu đề tin" type="text" min="5" maxlength="400" autocomplete="on" autofocus="autofocus" required="required"> 
						</div>
						<div class="col-md-3">
							<span id="error.newType" class="message_error"></span>
							<select id="newType" name ="newType"  class="selectpicker" style="width: 100%">
							  <option value="">Phân loại</option>
							  <option value="SELL_APARTMENT">Bán căn hộ chung chư</option>
							  <option value="SELL_HOUSE">Bán nhà riêng</option>
							  <option value="SELL_HOUSE_ADJACENT">Bán nhà biệt thự liền kề</option>
							  <option value="SELL_HOUSE_FRONT_ROAD">Bán nhà mặt phố</option>
							  <option value="SELL_LAND_PROECT">Bán đất nền dự án</option>
							  <option value="SELL_LAND">Bán đất</option>
							  <option value="SELL_FARM">Bán trang trại, khu nghỉ dưỡng</option>
							  <option value="SELL_STORE_HOUSE">Bán kho, nhà xưởng</option>
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
							  <option value="">Đơn vị</option>
							  <option value="MILLION_PER_MONTH">Triệu/Tháng</option>
							  <option value="MILLION_PER_SQUARE_METER">Triệu/M2</option>
							  <option value="HUNDERD_PER_MONTH">Trăm nghìn đồng/Tháng</option>
							  <option value="HUNDERD_PER_SQUARE_METER">Trăm nghìn đồng/Tháng</option>
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
								<span id="error.imageIds" class="message_error"></span>
								<input id="imageIds" name="imageIds" type="text" hidden="true" >
								<h6>Hình ảnh nhà đất</h6>
							</div>
							<div class="drop-images" style="margin-top: 10px" id="my-dropzone">
								<p>Kéo ảnh nhà đất vào ô này</p>
								 <div class="fallback">
								    <input name="file" type="file" multiple />
								  </div>
							</div>
						</div>
						<div class="col-md-6">

							<span id="error.address" class="message_error"></span>
							<input ID="address" name="address" required="required" class="form-control" placeholder="Địa chỉ" style="margin-top: 10px">
							<input name="lagtitude" type="number" hidden="true" value="105.7839107">
							<input name="longitude" type="number" hidden="true" value="21.0309421">

							<h6>Địa chỉ</h6>
							<label class="radio">
            					<input type="radio" name="positionOptions" id="posOption1" value="currentPos" data-toggle="radio" class="custom-radio">
            						<span class="icons">
            							<span class="icon-unchecked"></span>
            							<span class="icon-checked"></span>
            						</span>
           							Sử dụng địa điểm hiện tại
          					</label>
          					<label class="radio">
            					<input type="radio" name="positionOptions" id="posOption2" value="anotherPos" data-toggle="radio" class="custom-radio">
            						<span class="icons">
            							<span class="icon-unchecked"></span>
            							<span class="icon-checked"></span>
            						</span>
           							 Sử dụng địa điểm khác
          					</label>
          					<div class="map">
    							<div id="map" style="width:100%;height: 100%"></div>
    						</div>
          					<div id="posDetail">
           						<label>Địa chỉ được chọn</label>
           						<p/>
           						<input name="address" class="form-control" placeholder="Số nhà, ngõ, đường" type="text" min="5" maxlength="400" autocomplete="on" autofocus="autofocus" required="required"> 
           						<div id="posAdminDetail">
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
						<button type="button" class="btn btn-primary" onclick="submitForm(this)">Đăng tin</button>
					</div>
					
				</form>
	</div>
</div>
<script type="text/javascript">
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	var currentPos = findCurrentPos();
	//var infowindow = new google.maps.InfoWindow;
	//var geocoder = new google.maps.Geocoder;
	//geocodeLatLng(geocoder,currentPos,infowindow);
};

function geocodeLatLng(geocoder, latlng) {
	console.log(latlng);
    geocoder.geocode({'location': latlng}, function(results, status) {
      if (status === 'OK') {
    	console.log('Result');
    	console.log(results);
        if (results[1]) {
          map.setZoom(11);
          var marker = new google.maps.Marker({
            position: latlng,
            map: map
          });
          //infowindow.setContent(results[1].formatted_address);
          //infowindow.open(map, marker);
        } else {
          window.alert('No results found');
        }
      } else {
        window.alert('Geocoder failed due to: ' + status);
      }
    });
};
    
var cleanMap = function(){
	
}

var processBasePosition = function(postion, map){
	var marker = new google.maps.Marker({map: map});
	marker.setPosition(postion);
    map.setCenter(postion);
}	

var paths = [];
//Disabling autoDiscover, otherwise Dropzone will try to attach twice.
Dropzone.autoDiscover = false;
// or disable for specific dropzone:
// Dropzone.options.myDropzone = false;

$(function() {
  // Now that the DOM is fully loaded, create the dropzone, and setup the
  // event listeners
  var myDropzone = new Dropzone("#my-dropzone", { url: ctx + "/news/uploadImages",addRemoveLinks:true});
  myDropzone.on("addedfile", function(file) {
    /* Maybe display some more file information on your page */
    console.log("adding file");
    console.log(file);
  });
  myDropzone.on("success", function(file,data) {
    /* Maybe display some more file information on your page */
    console.log("adding success");
    file.path=data.path;
    console.log(file.name);
    console.log(data);
    
    paths.push(data.path);
    
  });
  myDropzone.on("removedfile", function(file) {
    /* Maybe display some more file information on your page */
    console.log("removedfile");
    console.log(file);
    var name = file.name;
    console.log(name);
    console.log(file.path);
    paths.splice( paths.indexOf(file.path), 1 );
  });
  $("#my-dropzone").addClass("dropzone");
})

var saveNewsCallback = function(form,data){
	console.log(data);
	window.location.href=ctx+'/thanh-vien/quan-ly-tin';
}

function showFormError(restError, formId) {

	hiddeFormError(formId);
	var fieldErrors = restError.fieldErrors;

	$.each(fieldErrors, function(index, value) {

		$('form#' + formId + ' #' + value.fieldId).addClass('input_error');
		$field = $('form#' + formId + ' #error\\.' + value.fieldId);

		$field.text(value.errorMessage);
	});
}
var saveForm = function(form,callback){
		console.log("saveForm go");
		
		var myFormId= $(form).attr('id');
		
		console.log("saveFormAjax>>"+myFormId);
		
		var $myForm = $("#"+myFormId);
		// Find disabled inputs, and remove the "disabled" attribute
		var disabled = $myForm.find(':input:disabled').removeAttr('disabled');
		var formData = $myForm.serialize();
		// re-disabled the set of inputs that you previously enabled
		disabled.attr('disabled','disabled');
		
		var action = $("#"+myFormId).attr("action");
		
		$.ajax({ 
			url: action , 
			type: 'post', 
			data: formData,
			cache:false,
			suppressErrors:false,
			formId:myFormId,
			success: function(data, textStatus, jqXHR) {
				
					console.log("saveFormAjax success");
					//hidde all error
					hiddeFormError(myFormId);
					
					//call action callback with current form
					if(callback){
						eval(callback+'(form, data)');
					}else{
						showSaveSuccessNotification();
					}
					
									
				
			},complete: function(){
				console.log("saveFormAjax complete");
				return true;
				
			},error : function(request, status, error,event){
				console.log("saveFormAjax error");
				showSaveErrorNotification();
				return false;
			}
		});
	}
	
$(document).ready(function(){
	$("#posOption2").change(function(){ 
        if( $(this).is(":checked") ){ 
            console.log($(this).val());
        }
    });
	$("#posOption1").change(function(){ 
        if( $(this).is(":checked") ){ 
            console.log($(this).val());
        }
    });
	
});

</script>



	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>


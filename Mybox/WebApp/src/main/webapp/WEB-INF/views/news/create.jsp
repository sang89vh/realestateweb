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
				<form action="${ctx}/news/create" method="post" data-action="saveForm" data-callback="saveNewsCallback">
					<div class="col-md-12" style="background-color: #474e52; color: white;margin-bottom: 10px;">
						<h6>Thông tin nhà đất</h6>
					</div>
					
					<div class="row" style="margin-top: 10px">
						<div class="col-md-9">
							<input name="title" class="form-control" placeholder="Tiêu đề tin" type="text" min="5" maxlength="400" autocomplete="on" autofocus="autofocus" required="required"> 
						</div>
						<div class="col-md-3">
							<select name ="typeNews"  class="selectpicker" style="width: 100%">
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
							<input name="acreage" type="number" min="0" required="required" class="form-control" placeholder="Điện tích(m²)">
						</div>
						<div class="col-md-3">
							<input name="price" type="number" min="0" required="required" class="form-control" placeholder="Giá">
						</div>
						<div class="col-md-3">
							<select name="priceUnit"  class="selectpicker" required="required">
							  <option>Đơn vị</option>
							  <option>Triệu</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<textarea name="content"  required="required"  class="form-control" rows="9"></textarea>
							<input name="mobile" type="number" required="required"  class="form-control" placeholder="Điện thoại liên hệ">
							<div class="images">
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
							<h6>Địa chỉ</h6>
							Vị trí hiện tại của bạn
							<div class="map">
    							<div id="map" style="width:100%;height: 100%"></div>
    						</div>
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
	findCurrentPos();
	
}

var findCurrentPos = function(){
	//cleanMap();		
	var markerCurrentPos = new google.maps.Marker({map: map, title: 'You are here'});
	// Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var currentPos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        //infoWindow.setPosition(currentPos);
        //infoWindow.setContent('Location found.');
		markerCurrentPos.setPosition(currentPos);
        map.setCenter(currentPos);
        oldBound = map.getBounds();
        baseMarkers.push(markerCurrentPos);
        findDistrictForMarker(markerCurrentPos);
        //console.log(currentPos);
      }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
    }  
};
</script>

<script type="text/javascript">
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

var submitForm = function(btn){
	form = $(btn).parents('form');
	var action = form.attr("data-action")
	var callback = form.attr("data-callback")
	eval(action+"("+form+","+callback+")");
}
var saveNewsCallback = function(form,data){
	console.log(data);
	
}
var showSaveErrorNotification = function(){
	sweetAlert("Oops...", "Something went wrong!", "error");
}
var showSaveSuccessNotification = function(){
	swal("Good job!", "You clicked the button!", "success");
}
function hiddeFormError(formId) {

	var allMessError = $('form#' + formId + ' .message_error');
	$(allMessError).each(function() {

		$(this).text('');

	});

	$('form#' + formId + ' .input_error').each(function() {

		$(this).removeClass('input_error');

	});

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
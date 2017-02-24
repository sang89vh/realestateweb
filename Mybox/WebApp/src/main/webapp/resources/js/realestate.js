$.ajaxSetup({
	timeout: 30000000 
});

$(document).ajaxStart(function(){
	//console.log("ajaxStart");
});  
$(document).ajaxStop(function(){
	//console.log("ajaxStop");
});

$(document).ajaxComplete(function(a,b,c,d,e){
	//console.log("ajaxComplete");
});


$(document).ajaxError(function(event, jqxhr, settings, exception) {
	  
	if(settings.suppressErrors) {
        return;
    }else{
		var cont = "";
		
	    if (jqxhr.status === 400) { 
	    	//hidden confirm message
			//swal.close();
			
			var restError = JSON.parse(jqxhr.responseText);
			
			console.log(restError);
			
			if(restError.errorCode === 'FORM_VALIDATE_ERROR'){
				showFormError(restError,settings.formId);
			}else if(restError.errorCode === 'BUSINESS_ERROR'){
				showBusinessError(restError);
			}else if(restError.errorCode === 'UNKNOWN_ERROR'){
				showBusinessError(restError);
			}else{
				showBusinessError(restError);
			}
			
			return;
			
	    } else if (jqxhr.status === 0) {
	        cont = 'Not connect. Verify Network.('+exception+')';
	    } else if (jqxhr.status == 404) {
	        cont = 'Requested page not found. [404].('+exception+')';
	    } else if (jqxhr.status == 500) {
	        cont = 'Internal Server Error [500].('+exception+')';
	    } else if (exception === 'parsererror') {
	        cont = 'Requested JSON parse failed.';
	    } else if (exception === 'timeout') {
	        cont = 'Time out error.';
	    } else if (exception === 'abort') { 
	        cont = 'Ajax request aborted.';
	    } else {
	        cont = 'Uncaught Error.<br/>' + jqxhr.responseText;
	    }
    }
});

$(document).ready(function() {
	$(".fffancybox").fancybox({
		maxWidth	: 2560,
		maxHeight	: 1600,
		fitToView	: false,
		width		: '98%',
		height		: '98%',
		autoSize	: false,
		closeClick	: false,
		openEffect	: 'none',
		closeEffect	: 'none'
	});
});

$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
        	var oldVal = o[this.name];
            o[this.name] = oldVal + "," + this.value;
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//Home path
//var homePage ="/mybox/"
//GG Map

var bindingForm = function(formId, data) {
	console.log('bindingForm');
	console.log(formId);
	console.log(data);

	$('#' + formId + ' input, #' + formId + ' select, #' + formId + ' textarea').each(
			function(i, val) {
				var inpName = $(this).attr('name');
				if (inpName != null && inpName != undefined) {
					var key = inpName.split('.').pop();
					if ($(this).attr('type') == 'radio') {
						if ($(this).val() == data[key]) {
							$(
									'input[name="' + $(this).attr('name')
											+ '"][value="' + data[key] + '"]')
									.prop('checked', true);
						}
					} else {
						$(this).val(data[key]);
					}
				}
			});
}


var submitForm = function(btn){
	console.log(btn);
	
	var form = $(btn).parents('form');
	var action = form.attr("data-action")
	var callback = form.attr("data-callback")
	eval(action+"(form,callback)");
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
function showBusinessError(restError){
	sweetAlert("Oops...", restError.message, "error");
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
var saveForm = function($myForm,callback){
		console.log("saveForm go");
		
		
		// Find disabled inputs, and remove the "disabled" attribute
		var disabled = $myForm.find(':input:disabled').removeAttr('disabled');
		var formData = $myForm.serialize();
		
		// re-disabled the set of inputs that you previously enabled
		disabled.attr('disabled','disabled');
		var myFormId = $myForm.attr("id");
		var action = $myForm.attr("action");
		
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
						eval(callback+'($myForm, data)');
					}else{
						showSaveSuccessNotification();
					}
					
									
				
			},complete: function(){
				console.log("saveFormAjax complete");
				return true;
				
			},error : function(request, status, error,event){
				console.log("saveFormAjax error");
				//showSaveErrorNotification();
				return false;
			}
		});
}

var changeLanguage = function(lang){
	$.get( ctx + "/language/change-to?lang="+lang, function( data ) {
	  window.location.reload();
	})
}

var changeNewsType=function(selectbox){
}

var changePrice=function(selectbox){
	
}

var changeBeds=function(selectbox){
	
}
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	findCurrentPos(true,3);
	prepareSearchLocation(document.getElementById('search-location-text'),true,3);
};

var updateAdminInfo = function(specificAddress,adminAddress,note){
	$("#address").val(specificAddress);
	var str = "phường " + adminAddress.ward
			+ ", quận " + adminAddress.district
			+ ", thành phố " + adminAddress.city
	$("#posAdminDetail").html(str);
	$("#posLatLng").html(note);
}


var paths = [];
//Disabling autoDiscover, otherwise Dropzone will try to attach twice.
Dropzone.autoDiscover = false;
// or disable for specific dropzone:
// Dropzone.options.myDropzone = false;

$(function() {
  // Now that the DOM is fully loaded, create the dropzone, and setup the
  // event listeners
  var myDropzone = new Dropzone("#my-dropzone", { url: ctx + "/member/uploadImages",addRemoveLinks:true});
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
var preSubmitForm = function(btn){
	$("#imageIds").val(paths.toString());
	submitForm(btn);
}
var saveNewsCallback = function(form,data){
	console.log(data);
	window.location.href=ctx+'/member/manage-news';
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

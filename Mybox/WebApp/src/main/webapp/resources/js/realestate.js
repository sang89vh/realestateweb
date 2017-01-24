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
			//hidden confirm message
			swal.close()
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
var homePage ="/mybox/"
//GG Map

var map;

var findDistrictForMarker = function (marker){
	console.log('findDistrict');
	console.log(marker);
	var geocoder = new google.maps.Geocoder;
	var latlng = {lat: marker.position.lat(), lng: marker.position.lng()};
	var districtAndCity = {};
	geocoder.geocode({'location': latlng}, function(results, status) {
          if (status === 'OK') {
            if (results[0]) {     
            	$.each(results, function(index,item){
            		if (item.types[0] === "administrative_area_level_3" && item.types[1] === "political"){
            			districtAndCity.district =  item.address_components[1].long_name;
            			districtAndCity.city =  item.address_components[2].long_name;
            		}
            	})
            	if (districtAndCity.district != null  && districtAndCity.city != null){
            		var para = districtAndCity.district +"," + districtAndCity.city;
    				$.ajax({ 
        				url: ctx + '/map/get-polygon' , 
        				//type: 'post', 
        				data: {name: para},
        				cache:false,
        				suppressErrors:false,
        				success: function(data, textStatus, jqXHR) {
        					$.each(data, function(index,item){
        						var paths = [];
        						$.each(item.Polygon, function(index1,item1){
        							var path = {
        									lat: item1.latitude,
        									lng: item1.longitude
        							}
        							paths.push(path);
        						})            					      
        					    var polygon = new google.maps.Polygon({
        					          paths: paths,
        					          strokeColor: '#FF0000',
        					          strokeOpacity: 0.1,
        					          strokeWeight: 0,
        					          fillColor: '#FF0000',
        					          fillOpacity: 0.1
        					        });
        						polygon.setMap(marker.map);
        						polygons.push(polygon);	        					        
        					})
        					
        				},complete: function(){
        					return true;		
        				},error : function(request, status, error,event){
        					return false;
        				}
        			});
    				
    			}
            } else {
              window.alert('No results found');
            }
          } else {
            window.alert('Geocoder failed due to: ' + status);
          }
        });		
};

var addListenerIdleToMap = function(map){
	map.addListener('idle', function() {
	   	 if (map.getBounds() != null){
	   		var bound = {
	   				southwestLatitude: map.getBounds().f.f,
	   				southwestLongitude: map.getBounds().b.b,
	   				northeastLatitude: map.getBounds().f.b,
	   				northeastLongitude: map.getBounds().b.f,
	   			}
	   		//console.log(map.getBounds());
	   		loadRentHouses(bound);
	   	 }		   		
	     });
};




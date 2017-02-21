
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	
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
	
	var markerBasePos = new google.maps.Marker({
		map: map,
        position: {lat: baseLat, lng: baseLng},
	});
}
var searchLocations = function(){
	var locationAutocomplete = new google.maps.places.Autocomplete(document.getElementById('search-location-text'));
	var searchAddress =  document.getElementById('search-location-text');
	var searchBox = new google.maps.places.SearchBox(searchAddress);
	
	searchBox.addListener('places_changed', function() {
		var url = ctx 
			+ '?search=' + encodeURIComponent($("#search-location-text").val())
			+ '&type=' + $("#type").val()
			+ '&price=' + $("#price").val()
			+ '&numBed=' + $("#numBed").val();
		var link = document.createElement('a');
		link.href = url;
		document.body.appendChild(link);
		link.click();
	});
	
}

$(document).ready(function() {
 	$("#type").val("${type}");
 	$("#price").val("${price}");
 	$("#numBed").val("${numBed}");
	searchLocations();
});



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
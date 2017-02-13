var findCurrentPos = function(map,polygons,adminLevel){
	cleanMap();	
	var currentPos;
	var markerCurrentPos = new google.maps.Marker({map: map, title: 'You are here'});
	// Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        currentPos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        
        addBaseMarkerToPos(currentPos,map,'You are here');
	    map.setCenter(currentPos);
	    findPosAdminInfo(currentPos.lat,currentPos.lng,map,polygons,adminLevel);
      }, function() {
        handleLocationError(true, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
    handleLocationError(false, map.getCenter());
    }
};

var handleLocationError = function(isBrowserSupport, mapCenter){
	alert('location error');
}

/**
 * level 1
 * level 2 = quan
 * level 3 = phuong
 */
var findPosAdminInfo = function (lat,lng,map,polygons,level){
	console.log('findAdminInfo');
	var geocoder = new google.maps.Geocoder;
	var adminAddress = {};
	var pos = {
		lat: lat,
		lng: lng
	}
	geocoder.geocode({'location': pos}, function(results, status) {
          if (status === 'OK') {
        	  console.log('Results');
        	  console.log(results);
            if (results[0]) {     
            	$.each(results, function(index,item){
            		if (item.types[0] === "administrative_area_level_3" && item.types[1] === "political"){
            			adminAddress.ward = item.address_components[0].long_name;
            			adminAddress.district =  item.address_components[1].long_name;
            			adminAddress.city =  item.address_components[2].long_name;
            		}
            	})
            	if (adminAddress.ward != null && adminAddress.district != null  && adminAddress.city != null){
            		var para;
            		switch (level) {
					case 1:
						para = adminAddress.city;
						break;
					case 2:
						para = "quan " + adminAddress.district +"," + adminAddress.city;
						break;
					case 3:
						para = "phuong " + adminAddress.ward + ",quan " + adminAddress.district +"," + adminAddress.city;
						break;
					default:
						break;
					}
            		if (para !== null && para !== undefined){
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
            						polygon.setMap(map);
            						polygons.push(polygon);	        					        
            					})
            					
            				},complete: function(){
            					return true;		
            				},error : function(request, status, error,event){
            					return false;
            				}
            			});
            		}
    				
    				
    			}
            } else {
              window.alert('No results found');
            }
          } else {
            window.alert('Geocoder failed due to: ' + status);
          }
        });		
};

var addBaseMarkerToPos = function(pos,map,content){
	console.log('add marker');
	var infoWindow = new google.maps.InfoWindow({content: content});
    
    baseMarker = new google.maps.Marker({
		map:map,
		position:pos,
		infoWindow:infoWindow});
	
	baseMarker.addListener('click', function() {
        if (infoWindow.marker == this) {
          console.log("This infowindow already is on this marker!");
        } else {
        	infoWindow.open(map, baseMarker);
        	infoWindow.addListener('closeclick', function() {
        		infoWindow.marker = null;
            });
        }
  	});
	
	
	return baseMarker;
}

var getPlaceGGInfo = function(place,polygons,map){
	var service = new google.maps.places.PlacesService(map);
    service.getDetails({
      placeId: place.place_id
    }, function(place, status) {
//    	console.log('Place');
//    	console.log(place);
    	if (status === google.maps.places.PlacesServiceStatus.OK) {
            // Set the marker property on this infowindow so it isn't created again.
            var innerHTML = '<div>';
            if (place.name) {
              innerHTML += '<strong>' + place.name + '</strong>';
            }
            if (place.formatted_address) {
              innerHTML += '<br>' + place.formatted_address;
            }
            if (place.formatted_phone_number) {
              innerHTML += '<br>' + place.formatted_phone_number;
            }
            if (place.opening_hours) {
              innerHTML += '<br><br><strong>Hours:</strong><br>' +
                  place.opening_hours.weekday_text[0] + '<br>' +
                  place.opening_hours.weekday_text[1] + '<br>' +
                  place.opening_hours.weekday_text[2] + '<br>' +
                  place.opening_hours.weekday_text[3] + '<br>' +
                  place.opening_hours.weekday_text[4] + '<br>' +
                  place.opening_hours.weekday_text[5] + '<br>' +
                  place.opening_hours.weekday_text[6];
            }
            if (place.photos) {
              innerHTML += '<br><br><img src="' + place.photos[0].getUrl(
                  {maxHeight: 100, maxWidth: 200}) + '">';
            }
            innerHTML += '</div>';      
            addBaseMarkerToPos(place.geometry.location,map,innerHTML);
          }
    });
  
}

var seachPosAtStart = function(map,query,searchBox){
	service = new google.maps.places.PlacesService(map);
	request = {
			query: query
          };
	 service.textSearch(request, function(places) {
         //set the places-property of the SearchBox
         //places_changed will be triggered automatically
         searchBox.set('places', places || [])
       });
}

var prepareSearchLocation = function(map,searchAddressElement){
	var locationAutocomplete = new google.maps.places.Autocomplete(searchAddressElement);
	var searchBox = new google.maps.places.SearchBox(searchAddressElement);
		 //var searchBox = new google.maps.places.Autocomplete(searchAddress);
	    
	 	// Bias the SearchBox results towards current map's viewport.
	map.addListener('bounds_changed', function() {
	   	searchBox.setBounds(map.getBounds());
	});
	 
	       // Listen for the event fired when the user selects a prediction and retrieve
	       // more details for that place.
	      
	searchBox.addListener('places_changed', function() {
	 	console.log('place changed');
	   	cleanMap();
	    var places = searchBox.getPlaces();
	    if (places.length == 0) {
	       return;
	    }
	            
	            // For each place, get the icon, name and location.
	    var bounds = new google.maps.LatLngBounds();
	    	places.forEach(function(place) {	    		
	    	   if (!place.geometry) {
	           	console.log("Returned place contains no geometry");
	           	return;
	    		}
	          	getPlaceGGInfo(place,polygons,map);
	          	findPosAdminInfo(place.geometry.location.lat(),place.geometry.location.lng(),map,polygons,2);
	          	if (place.geometry.viewport) {
	                    // Only geocodes have viewport.
	               bounds.union(place.geometry.viewport);
	            } else {
	               bounds.extend(place.geometry.location);
	                  }
	            })
	            map.fitBounds(bounds);
	            oldBound = map.getBounds();
		 })
	return searchBox;	 
};

var clusterMarkers = function(map,markers){
	console.log('cluster now');
	
	var mcOptions = {
			gridSize: 50,
			//maxZoom: 15,
			//title: 'Multiple Users',
			imagePath: ctx + '/resources/img/icons/map/markercluster/',
		};
	var markerCluster = new MarkerClusterer(map, markers, mcOptions);
	var infowindow = new google.maps.InfoWindow();
	google.maps.event.addListener(markerCluster, 'clusterclick', function(cluster) {
		console.log('zoom is : '+map.getZoom());
		if(map.getZoom()> 20)
		{
			var content = '';
			$.each(cluster.getMarkers(), function(index,item){
				content += item.infowindow.content;
			})
			infowindow.setPosition(cluster.getCenter());
			infowindow.setContent(content);
			infowindow.open(map);
		}
	});
}
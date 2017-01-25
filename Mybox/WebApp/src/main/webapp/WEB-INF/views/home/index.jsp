
    <style>

      #map {
        height: 100%;
      }
    </style>
    
	<div class="row" >
		<div class="col-md-5 news-container" style="height: 500px;overflow-y: scroll;">
			<div class="row" id="new-row"></div>
		</div>
    	<div class="col-md-7 map">
    		<div id="map" class="col-md-7" style="width:100%;height: 100%"></div>
    	</div>
    </div>
    <div id="temp-row" style="display: none;">
		<div class="item well">
			<a href="#">
				<img alt="" src="" style="width: 100%;height: auto;">
			</a>
			<b class="price" ></b><br/>
			<span class="info"></span><br/>
			<span class="address"></span><br/>
		</div>
	</div>
	
    
    <script>
	 
    var houseMarkers = [];
    var baseMarkers = [];
    var polygons = [];
    var searchBox;

    var initMap = function() {	
	    map = new google.maps.Map(document.getElementById('map'), {
	     	zoom: 15
	     });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	     //searchBox.setBounds(map.getBounds());
	    prepareSearchLocation();
	    if ($("#search-location-text").val() === ''){
	    	findCurrentPos();
	    } else {
	    	service = new google.maps.places.PlacesService(map);
	    	request = {
	    			query: $("#search-location-text").val()
	              };
	    	 service.textSearch(request, function(places) {
	             //set the places-property of the SearchBox
	             //places_changed will be triggered automatically
	             searchBox.set('places', places || [])
	           });
	    }
	    
	    addListenerIdleToMap(map);   	
	   	
	};
	
	/*
	 $( "#search-location" ).click(function() {	 
		 searchLocations();
	 });
	*/
	
	 var findCurrentPos = function(){
			cleanMap();		
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
		        baseMarkers.push(markerCurrentPos);
		        findDistrictForMarker(markerCurrentPos);
		        console.log(currentPos);
		      }, function() {
		        handleLocationError(true, infoWindow, map.getCenter());
		      });
		    } else {
		      // Browser doesn't support Geolocation
		    handleLocationError(false, infoWindow, map.getCenter());
		    }  
		};
	 
	 var prepareSearchLocation = function(){
			console.log('search locations');
			 var locationAutocomplete = new google.maps.places.Autocomplete(document.getElementById('search-location-text'));
			 var searchAddress =  document.getElementById('search-location-text');
			 searchBox = new google.maps.places.SearchBox(searchAddress);
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
		      	console.log('Place');
		      	console.log(places);
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
		          	    var searchMarker = new google.maps.Marker({
		                    map: map,
		                    //icon: icon,
		                    title: place.name,
		                    position: place.geometry.location,
		                    id: place.place_id
		                  });
		          	    var placeInfoWindow = new google.maps.InfoWindow();
		          	    searchMarker.addListener('click', function() {
		                 if (placeInfoWindow.marker == this) {
		                   console.log("This infowindow already is on this marker!");
		                 } else {
		                	 getGGPlacesDetails(this, placeInfoWindow);
		                 }
		          	  });
		          	  baseMarkers.push(searchMarker);
		          	  findDistrictForMarker(baseMarkers[0]);
		          	  if (place.geometry.viewport) {
		                    // Only geocodes have viewport.
		                    bounds.union(place.geometry.viewport);
		                  } else {
		                    bounds.extend(place.geometry.location);
		                  }
		            })
		            map.fitBounds(bounds);
		   	 
			 }) 
		};
	var loadRentHouses = function(obj){
		var iconHousePos = {
				  url: ctx + "/resources/img/icons/map/housePos.ico", // url
				  scaledSize: new google.maps.Size(40,40), // scaled size
				  origin: new google.maps.Point(0,0), // origin
				  anchor: new google.maps.Point(0, 0), // anchor
				};

		var locations = [];
		$.ajax({ 
			url: ctx + '/map/search-place?skip=50' , 
			//type: 'post', 
			data: obj,
			cache:false,
			suppressErrors:false,
			success: function(data, textStatus, jqXHR) {
				var $newsRow = $("#new-row");
				$newsRow.html('');
				$.each(data, function(index, item){					
					$newsRow.append(showNews(item));
					attachInfo(item);
				});
				autoClick();
			},complete: function(){
				return true;		
			},error : function(request, status, error,event){
				console.log('Error');
				return false;
			}
		});
	}
	
	var autoClick = function(){
		$("#new-row .item").on("mouseenter",function(){
			var obj =$(this).data();
			$.each(houseMarkers, function(index, item){
				if (item.id === obj.objectId){
					google.maps.event.trigger(item, 'click');
				} 
				else {
					item.infowindow.close();	
				}
			});
		});
	};
	
	var attachInfo = function(obj){
		var iconHousePos = {
				  url: ctx + "/resources/img/icons/map/housePos.ico", // url
				  scaledSize: new google.maps.Size(40,40), // scaled size
				  origin: new google.maps.Point(0,0), // origin
				  anchor: new google.maps.Point(0, 0), // anchor
				};
		var placeInfoWindow = new google.maps.InfoWindow();
		var marker = new google.maps.Marker({
		 	map: map,
            position: {lat:obj.location.latitude, lng:obj.location.longitude},
            title: obj.title,
			icon: iconHousePos,
            id: obj.objectId,
            infowindow: placeInfoWindow,
            //label: "Marker A"
          });
		houseMarkers.push(marker);
	
		// Create a single infowindow to be used with the place details information
    	// so that only one is open at once.
    	// If a marker is clicked, do a place details search on it in the next function.
     	marker.addListener('click', function() {
	        if (placeInfoWindow.marker == this) {
	          console.log("This infowindow already is on this marker!");
	        } else {
	        	$.each(houseMarkers, function(index,item){
	        		item.infowindow.close();
	        	});
	        	//placeInfoWindow.setContent(obj.objectId);
	        	placeInfoWindow.setContent(showNews(obj).html());
	        	placeInfoWindow.open(map, marker);
	            // Make sure the marker property is cleared if the infowindow is closed.
	            placeInfoWindow.addListener('closeclick', function() {
	            	placeInfoWindow.marker = null;
	            });
	        }
      	});
	}
	
	var showNews = function(obj){
			var temp=$("#temp-row").find(".item").clone();
			temp.data(obj);
			if (obj.thumbs){
				var $img = $(temp.find("img")[0]);
				$img.attr("src",obj.thumbs[0]);
			}
			
			
			var $a = $(temp.find("a")[0]);
			$a.attr("href",ctx+"/news/property?obj="+obj.objectId+"&lat="+baseMarkers[0].position.lat()+"&lng="+baseMarkers[0].position.lng());
			
			var $price = $(temp.find(".price")[0]);
			$price.text(obj.price)
			
			
			var $info = $(temp.find(".info")[0]);
			$info.html(obj.acreage)
			
			var $address = $(temp.find(".address")[0]);
			$address.html(obj.address)
			return temp;
	}

	
	var cleanMap = function(){
		$.each(baseMarkers, function(index,item){
			item.setMap(null)
		});
		$.each(houseMarkers, function(index,item){
			item.setMap(null)
		});
		$.each(polygons, function(index,item){
			item.setMap(null)
		});
		baseMarkers = [];
		houseMarkers = [];
		polygons = [];
	};
	
	// This is the PLACE DETAILS search - it's the most detailed so it's only
    // executed when a marker is selected, indicating the user wants more
    // details about that place.
    var getGGPlacesDetails = function(marker, infowindow) {
      var service = new google.maps.places.PlacesService(map);
      service.getDetails({
        placeId: marker.id
      }, function(place, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
        	console.log('status OK');
          // Set the marker property on this infowindow so it isn't created again.
          infowindow.marker = marker;
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
          infowindow.setContent(innerHTML);
          infowindow.open(map, marker);
          // Make sure the marker property is cleared if the infowindow is closed.
          infowindow.addListener('closeclick', function() {
            infowindow.marker = null;
          });
        }
      });
    }
    </script>

	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>

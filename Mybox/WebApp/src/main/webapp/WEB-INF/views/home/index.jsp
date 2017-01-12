
    <style>
      html,
      body {
        font-family: Arial, sans-serif;
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
    <!-- <form class="navbar-form" action="loadPosition" role="search">-->
		<div class="form-group">
        	<div class="input-group">
            	<input class="form-control" id="search-location-text" type="search" placeholder="Search for places">
            	<span class="input-group-btn">
                	<!-- <button type="submit" class="btn" id="search-within-time"><span class="fui-search"></span></button>  -->
                	<button class="btn" id="search-location"><span class="fui-search"></span></button>
                </span>
        	</div>
        </div>
     <!-- </form>  -->
	
    <div id="map" style="width: 100%; height: 500px"></div>
    <script>
     var map;
	 var markers = [];
	 var currentPos;
	 var searchBox;
	 
	 function initMap() {
		 var locationAutocomplete = new google.maps.places.Autocomplete(document.getElementById('search-location-text'));
		 //var searchBox = new google.maps.places.SearchBox(document.getElementById('search-location-text'));
	     map = new google.maps.Map(document.getElementById('map'), {
	       //center: {lat: -34.397, lng: 150.644},
	       zoom: 13
	     });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	     //searchBox.setBounds(map.getBounds());
	   
	     
	     findCurrentPos();		
	        //loadRentHouses();
		
	};
	
	 $( "#search-location" ).click(function() {	 
		  searchLocations();
	 });
	
	 var searchLocations = function(){
		 console.log('search location');
		 var address =  document.getElementById('search-location-text');
	     var searchBox = new google.maps.places.SearchBox(address);
	     
	  // Bias the SearchBox results towards current map's viewport.
	     //map.addListener('bounds_changed', function() {
	     //	searchBox.setBounds(map.getBounds());
	     //});
	  
	     var markers = [];
	        // Listen for the event fired when the user selects a prediction and retrieve
	        // more details for that place.
	     searchBox.addListener('places_changed', function() {
	    	 var places = searchBox.getPlaces();
	    	 console.log(places);
	          if (places.length == 0) {
	            return;
	          }
	          
	          // Clear out the old markers.
	          markers.forEach(function(marker) {
	              marker.setMap(null);
	            });
	          markers = [];
	          
	          // For each place, get the icon, name and location.
	          var bounds = new google.maps.LatLngBounds();
	          places.forEach(function(place) {
	        	  if (!place.geometry) {
	                  console.log("Returned place contains no geometry");
	                  return;
	                }
	        	  markers.push(new google.maps.Marker({
	                  map: map,
	                  //icon: icon,
	                  title: place.name,
	                  position: place.geometry.location
	                }));
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
	
	var findCurrentPos = function(){
		var iconCurrentPos = {
				  url: ctx + "/resources/img/icons/map/currentPos.ico", // url
				  scaledSize: new google.maps.Size(40,40), // scaled size
				  origin: new google.maps.Point(0,0), // origin
				  anchor: new google.maps.Point(0, 0) // anchor
				};
				
		var markerCurrentPos = new google.maps.Marker({map: map, title: 'You are here', icon: iconCurrentPos});
		// Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            currentPos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
			console.log('Current Pos');
			console.log(currentPos);
            //infoWindow.setPosition(currentPos);
            //infoWindow.setContent('Location found.');
			markerCurrentPos.setPosition(currentPos);
            map.setCenter(currentPos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
         handleLocationError(false, infoWindow, map.getCenter());
        }
        
	}
	
	
	
	var loadRentHouses = function(){
		var locations = [];
		$.ajax({ 
			url: ctx + '/map/search-place' , 
			//type: 'post', 
			//data: {FILE_IDS: fileIds},
			cache:false,
			suppressErrors:false,
			success: function(data, textStatus, jqXHR) {
				$.each(data, function(index, item){
					 var marker = new google.maps.Marker({
						 	map: map,
				            position: {lat:item.location.latitude, lng:item.location.longitude},
				            title: item.title,
				            animation: google.maps.Animation.DROP,
				            id: item.objectId
				          });
					 markers.push(marker);
				});			
			},complete: function(){
				return true;		
			},error : function(request, status, error,event){
				return false;
			}
		});
	}
	
	var loadPosition = function(){
		 var address = $("#search-within-time-text").val();
		 console.log(loadPosition);
	}
    </script>

    <script
        src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
    </script>


    <style>

      #map {
        height: 100%;
      }
    </style>
    <div class="row">
		<div class="form-group">
        	<div class="input-group">
            	<input class="form-control" id="search-location-text" type="search" placeholder="Search for places">
            	<span class="input-group-btn">
                	<!-- <button type="submit" class="btn" id="search-within-time"><span class="fui-search"></span></button>  -->
                	<button class="btn" id="search-location"><span class="fui-search"></span></button>
                </span>
        	</div>
        </div>
	</div>
	<div class="row" >
		<div class="col-md-5 news-container" style="height: 500px;overflow-y: scroll;">
			<div class="row" id="new-row"></div>
		</div>
    	<div class="col-md-7">
    		<div id="map" class="col-md-7" style="width:100%;height: 500px"></div>
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
     var map;
	 var houseMarkers = [];
	 var baseMarkers = [];
	 var locations = [];
	 var marker;
	 function initMap() {		 
	     map = new google.maps.Map(document.getElementById('map'), {
	       //center: {lat: -34.397, lng: 150.644},
	       zoom: 17
	     });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	     //searchBox.setBounds(map.getBounds());
	   
	   	 findCurrentPos();
	   	 
	   	 map.addListener('idle', function() {
	   		
	   		var bound = {
	   				southwestLatitude: map.getBounds().f.f,
	   				southwestLongitude: map.getBounds().b.b,
	   				northeastLatitude: map.getBounds().f.b,
	   				northeastLongitude: map.getBounds().b.f,
	   			}
	   		//console.log(map.getBounds());
	   		loadRentHouses(bound);
	     });
	   	searchLocations();
	        
		
	};
	
	 $( "#search-location" ).click(function() {	 
		 searchLocations();
	 });
	
	 var searchLocations = function(){
		
		 var locationAutocomplete = new google.maps.places.Autocomplete(document.getElementById('search-location-text'));
		 var searchAddress =  document.getElementById('search-location-text');
		 var searchBox = new google.maps.places.SearchBox(searchAddress);
	     
	     console.log(searchBox.getPlaces());
	  	// Bias the SearchBox results towards current map's viewport.
	     map.addListener('bounds_changed', function() {
	     	searchBox.setBounds(map.getBounds());
	     });
	  
	        // Listen for the event fired when the user selects a prediction and retrieve
	        // more details for that place.
	     searchBox.addListener('places_changed', function() {
	    	 cleanMakers();
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
	        	  baseMarkers.push(new google.maps.Marker({
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
		cleanMakers();		
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
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
         handleLocationError(false, infoWindow, map.getCenter());
        }    
	}
	
	var loadRentHouses = function(obj){
		var iconHousePos = {
				  url: ctx + "/resources/img/icons/map/housePos.ico", // url
				  scaledSize: new google.maps.Size(40,40), // scaled size
				  origin: new google.maps.Point(0,0), // origin
				  anchor: new google.maps.Point(0, 0), // anchor
				};
		
		$.ajax({ 
			url: ctx + '/map/search-place' , 
			//type: 'post', 
			data: obj,
			cache:false,
			suppressErrors:false,
			success: function(data, textStatus, jqXHR) {
				showNews(data);
				$.each(data, function(index, item){
					 marker = new google.maps.Marker({
						 	map: map,
				            position: {lat:item.location.latitude, lng:item.location.longitude},
				            title: item.title,
							icon: iconHousePos,
				            id: item.objectId,
				            label: "Marker A"
				          });
					 houseMarkers.push(marker);
					// Create a single infowindow to be used with the place details information
			        // so that only one is open at once.
			          var placeInfoWindow = new google.maps.InfoWindow();
			          // If a marker is clicked, do a place details search on it in the next function.
			          marker.addListener('click', function() {
			            if (placeInfoWindow.marker == this) {
			              console.log("This infowindow already is on this marker!");
			            } else {
			            	placeInfoWindow.setContent('aaaaaaaaaaaaaa');
			            	placeInfoWindow.open(map, marker);
			                // Make sure the marker property is cleared if the infowindow is closed.
			                placeInfoWindow.addListener('closeclick', function() {
			                	placeInfoWindow.marker = null;
			                });
			            }
			          });
				});			
			},complete: function(){
				return true;		
			},error : function(request, status, error,event){
				return false;
			}
		});
	}
	
	var cleanMakers = function(){
		 for (var i = 0; i < baseMarkers.length; i++) {
			 baseMarkers[i].setMap(null);
	     };
	     for (var i = 0; i < houseMarkers.length; i++) {
	    	 houseMarkers[i].setMap(null);
		 };   
	}
	var showNews = function(data){
		var $newsRow = $("#new-row");
		$newsRow.html('');
		$.each(data,function(index,item){
			var temp=$("#temp-row").find(".item").clone();
			
			var $img = $(temp.find("img")[0]);
			$img.attr("src",item.thumbs[0]);
			
			var $a = $(temp.find("a")[0]);
			$a.attr("href",ctx+"/news/property/"+item.objectId);
			
			var $price = $(temp.find(".price")[0]);
			$price.text(item.price)
			
			
			var $info = $(temp.find(".info")[0]);
			$info.html(item.acreage)
			
			var $address = $(temp.find(".address")[0]);
			$address.html(item.address)
			
			$newsRow.append(temp);
			
		})
	}
    </script>

    <script
        src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
    </script>

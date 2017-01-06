
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

    <div id="map" style="width: 100%; height: 500px"></div>
    <script>
     var map;
	 var markers = [];
	 var currentPos;
	 
	 function initMap() {
		 var currentPos;
	        map = new google.maps.Map(document.getElementById('map'), {
	          //center: {lat: -34.397, lng: 150.644},
	          zoom: 13
	        });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	        findCurrentPos();		
	        loadRentHouses();
		
	}
	 
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
    </script>

    <script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
    </script>


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
	 
    var targetMarkers = [];
    var polygons = [];
    var $newsRow = $("#new-row");
    var currentNews = [];
    var currentMarker;
    var oldBound;

    var initMap = function() {	
	    map = new google.maps.Map(document.getElementById('map'), {
	     	zoom: 15
	     });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	     //searchBox.setBounds(map.getBounds());
	    var searchBox = prepareSearchLocation(map,document.getElementById('search-location-text'));
	    if ($("#search-location-text").val() === ''){
	    	findCurrentPos(map,polygons,2);
	    } else {
	    	seachPosAtStart(map,$("#search-location-text").val(),searchBox);
	    }	    
	    addListenerIdleToMap(map);   	
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
		   		loadTargetsInBound(map,bound,true);
		   	 }		   		
		     });
	};
	
	/*
	 $( "#search-location" ).click(function() {	 
		 searchLocations();
	 });
	*/		
		
	var loadTargetsInBound = function(map,bound,isClustered){
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
			data: bound,
			cache:false,
			suppressErrors:false,
			success: function(data, textStatus, jqXHR) {
				
				//$newsRow.html('');
				$.each(data, function(index, item){
					var foundNews = false;
					$.each(currentNews, function(index1,item1){
						if (item1.objectId === item.objectId){
							foundNews = true;
							return false;
						}
					})
					if (!foundNews){
						$newsRow.append(showNews(item));
						attachMarkerToObject(item);
						currentNews.push(item);
					}
					
				});
				//console.log(currentNews.length);
				
				if (isClustered){
					clusterMarkers(map,targetMarkers);
				}
				autoClickCoMarker(map,isClustered);
			},complete: function(){
				return true;		
			},error : function(request, status, error,event){
				console.log('Error');
				return false;
			}
		});
	}
	
	var autoClickCoMarker = function(map,isClustered){
		$("#new-row .item").on("mouseenter",function(){
			var obj =$(this).data();
			if (currentMarker != undefined){
				currentMarker.setAnimation(null);
				currentMarker.infowindow.close();
				if (isClustered){
					currentMarker.setMap(null);
					//add 1 to ClusterIcon if want more exact result
				}		
			} 
			$.each(targetMarkers, function(index, item){
				if (item.id === obj.objectId){
					//google.maps.event.trigger(item, 'click');
					if (isClustered){
						item.setMap(map);
						//reduce 1 from ClusterIcon if want more exact result
					}
					item.setAnimation(google.maps.Animation.BOUNCE);
					//cleanPolygons();
					//findDistrictForMarker(item);
					currentMarker = item;
					return false;
				} 
			});
			
		}).on("mouseleave",function(){
			$.each(targetMarkers, function(index, item){
				item.setAnimation(null);
				if (isClustered){
					item.setMap(null);
					//add 1 to ClusterIcon if want more exact result
				}		
			});
		});
	};
	
	var attachMarkerToObject = function(obj){
		var iconHousePos = {
				  url: ctx + "/resources/img/icons/map/housePos.ico", // url
				  scaledSize: new google.maps.Size(40,40), // scaled size
				  origin: new google.maps.Point(0,0), // origin
				  anchor: new google.maps.Point(0, 0), // anchor
				};
		var placeInfoWindow = new google.maps.InfoWindow();
		placeInfoWindow.setContent(showNews(obj).html());
		var marker = new google.maps.Marker({
		 	map: map,
            position: {lat:obj.location.latitude, lng:obj.location.longitude},
            title: obj.title,
			icon: iconHousePos,
            id: obj.objectId,
            infowindow: placeInfoWindow,
            label: obj.price
          });
		
		targetMarkers.push(marker);
	
		// Create a single infowindow to be used with the place details information
    	// so that only one is open at once.
    	// If a marker is clicked, do a place details search on it in the next function.
     	marker.addListener('click', function() {
	        if (placeInfoWindow.marker == this) {
	          console.log("This infowindow already is on this marker!");
	        } else {
	        	if (currentMarker != undefined){
					currentMarker.setAnimation(null);
					currentMarker.infowindow.close();
				} 
	        	
	        	
				//cleanPolygons();
				//findDistrictForMarker(marker);
	        	placeInfoWindow.open(map, marker);
	        	currentMarker = marker;
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
			$a.attr("href",ctx+"/news/property?obj="+obj.objectId
					+"&lat="+baseMarker.position.lat()
					+"&lng="+baseMarker.position.lng()
					+"&search="+encodeURIComponent($("#search-location-text").val()));
			
			$a.attr("onclick","window.open(this.href); return false;");
			var $price = $(temp.find(".price")[0]);
			$price.text(obj.price)
			
			
			var $info = $(temp.find(".info")[0]);
			$info.html(obj.acreage)
			
			var $address = $(temp.find(".address")[0]);
			$address.html(obj.address)
			return temp;
	}

	var cleanMap = function(){
		cleanTargetMarkers();
		cleanPolygons();
		currentNews = [];
		$newsRow.html('');
	};
	
	var cleanTargetMarkers = function(){
		$.each(targetMarkers, function(index,item){
			item.setMap(null)
		});
		targetMarkers = [];
	}
	
	var cleanPolygons = function(){
		$.each(polygons, function(index,item){
			item.setMap(null)
		});
		polygons = [];
	}
	
    </script>

	<script
		src="https://maps.googleapis.com/maps/api/js?libraries=places,geometry&key=AIzaSyCcDHHuK_bGlftUhpq-MWo72JwD0-PYrv8&v=3&callback=initMap">
	</script>

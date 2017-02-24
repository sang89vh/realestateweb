    var targetMarkers = []; 
    var $newsRow = $("#new-row");
    var currentNews = [];
    var currentMarker;
    var oldBound;
    var isClustered = false;
    var searchPara = {};

    var initMap = function() {	
	    map = new google.maps.Map(document.getElementById('map'), {
	     	zoom: 15
	     });
	        //var infoWindow = new google.maps.InfoWindow({map: map});
	     //searchBox.setBounds(map.getBounds());
	    var searchBox = prepareSearchLocation(document.getElementById('search-location-text'),false,2);
	    if ($("#search-location-text").val() === ''){
	    	findCurrentPos(false,2);
	    } else {
	    	seachPosAtStart($("#search-location-text").val(),searchBox);
	    }	    
	    addListenerIdleToMap();   	
	};
	
	var addListenerIdleToMap = function(){
		map.addListener('idle', function() {
		   	 if (map.getBounds() != null){
		   		/*
		   		 var bound = {
		   				southwestLatitude: map.getBounds().f.f,
		   				southwestLongitude: map.getBounds().b.b,
		   				northeastLatitude: map.getBounds().f.b,
		   				northeastLongitude: map.getBounds().b.f,
		   			}
		   		//-console.log(map.getBounds());
		   		*/
		   		//loadTargetsInBound(bound,false);
		   		searchPara.southwestLatitude = map.getBounds().f.f;
		   		searchPara.southwestLongitude = map.getBounds().b.b;
		   		searchPara.northeastLatitude = map.getBounds().f.b;
		   		searchPara.northeastLongitude =  map.getBounds().b.f;
		   		loadTargetsInBound(searchPara,isClustered);
		   	 }		   		
		     });
	};
	
	/*
	 $( "#search-location" ).click(function() {	 
		 searchLocations();
	 });
	*/		
		
	var loadTargetsInBound = function(bound,isClustered){
		currentNews=[];
		$newsRow.html('');
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
				
//				cleanMap();
				$.each(data, function(index, item){
					//var foundNews = false;
// 					$.each(currentNews, function(index1,item1){
// 						if (item1.objectId === item.objectId){
// 							foundNews = true;
// 							return false;
// 						}
// 					})
// 					if (!foundNews){
 						$newsRow.append(showNews(item));
						attachMarkerToObject(item);
 						currentNews.push(item);
// 					}
					
				});
				//console.log(currentNews.length);
				
				if (isClustered){
					clusterMarkers(targetMarkers);
				}
				autoClickCoMarker(isClustered);
			},complete: function(){
				return true;		
			},error : function(request, status, error,event){
				console.log('Error');
				return false;
			}
		});
	}
	
	var autoClickCoMarker = function(isClustered){
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
		var placeInfoWindow = new google.maps.InfoWindow({
			disableAutoPan: true,
			content: showNews(obj).html(),
			maxHeight:200,
			maxWidth:200
		});
		var marker = new google.maps.Marker({
		 	map: map,
            position: {lat:obj.location.latitude, lng:obj.location.longitude},
            title: obj.title,
			icon: iconHousePos,
            id: obj.objectId,
            infowindow: placeInfoWindow,
            //label: obj.price
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
					+"&search="+encodeURIComponent($("#search-location-text").val())
					+"&type="+$("#type").val()
					+"&price="+$("#price").val()
					+"&numBed="+$("#numBed").val());
			
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
	
	var getPolygons = function(){
		return polygons;
	}
	
	var changeType=function(selectbox){
		updateSearchType(selectbox);
		loadTargetsInBound(searchPara,isClustered);
	}
	
	var changePrice=function(selectbox){
		updateSearchPrice(selectbox);
		loadTargetsInBound(searchPara,isClustered);
	}

	var changeNumBed=function(selectbox){
		updateSearchNumBed(selectbox);
		loadTargetsInBound(searchPara,isClustered);
	}
	
	var updateSelectedVal = function(){
		$("#type").val("${type}");
		$("#price").val("${price}");
		$("#numBed").val("${numBed}");
		
		updateSearchType(document.getElementById('type'));
		updateSearchPrice(document.getElementById('price'));
		updateSearchNumBed(document.getElementById('numBed'));
		
		loadTargetsInBound(searchPara,isClustered);
	}
	
	var updateSearchType = function(selectbox){
		searchPara.type = $(selectbox).val();
	}

	var updateSearchPrice = function(selectbox){
		var value= $(selectbox).val();
		var fromPrice=null;
		var toPrice=null;
		console.log(value);
		
		switch (value) {
			case  'SEARCH_PRICE_200':
				fromPrice=200;
				toPrice=300;
				break;
			case  'SEARCH_PRICE_300':
				fromPrice=300;
				toPrice=400;
				break;
			case  'SEARCH_PRICE_400':
				fromPrice=400;
				toPrice=500;
				break;
			case  'SEARCH_PRICE_500':
				fromPrice=500;
				toPrice=1000;
				break;
			case  'SEARCH_PRICE_1000':
				fromPrice=1000;
				toPrice=2000;
				break;
			case  'SEARCH_PRICE_2000':
				fromPrice=2000;
				toPrice=3000;
				break;
			case  'SEARCH_PRICE_3000':
				fromPrice=3000;
				toPrice=5000;
				break;
			case  'SEARCH_PRICE_5000':
				fromPrice=5000;
				toPrice=8000;
				break;
			case  'SEARCH_PRICE_8000':
				fromPrice=8000;
				toPrice=10000;
				break;
			default: 
				fromPrice=null;
				toPrice=null;
		}
		if (fromPrice != null){
			searchPara.fromPrice = fromPrice;
		}
		if (toPrice != null){
			searchPara.toPrice = toPrice;
		}
	}

	var updateSearchNumBed = function(selectbox){
		var value= $(selectbox).val();
		console.log(value);
		var numBed = null;
		switch (value) {
			case 'SEARCH_BEDS_1' :
				numBed = 1;
				break;
			case 'SEARCH_BEDS_2' :
				numBed = 2;
				break;
			case 'SEARCH_BEDS_3' :
				numBed = 3;
				break;
			case 'SEARCH_BEDS_4' :
				numBed = 4;
				break;
			case 'SEARCH_BEDS_5' :
				numBed = 5;
				break;
			case 'SEARCH_BEDS_6' :
				numBed = 6;
				break;
			default :
				numBed = 0;
		}
		searchPara.numBed = numBed;
	}
	
	$( document ).ready(function() {
	    updateSelectedVal();
	});
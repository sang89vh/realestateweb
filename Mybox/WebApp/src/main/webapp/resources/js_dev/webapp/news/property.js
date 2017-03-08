
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	
	var targetPos = {
		lat: parseFloat(lat),
	    lng: parseFloat(lng)
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
        position: targetPos,
        //title: obj.title,
		icon: iconTargetPos,
        //id: news.objectId,
        //infowindow: placeInfoWindow,
        //label: "Marker A"
      });
	var markerBasePos = new google.maps.Marker({
		map: map,
	       position: {lat: parseFloat(baseLat), lng: parseFloat(baseLng)},
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
 	$("#type").val(type);
 	$("#price").val(price);
 	$("#numBed").val(numBed);
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


//for comment
$(function() {

    var generateComment = function(data){
        $(data.pings).each(function(index, id) {
            var user = usersArray.filter(function(user){return user.id == id})[0];
            data.content = data.content.replace('@' + id, '@' + user.fullname);
        });
        //submit data

        var comment = {
            objId: objId,
            data: data
        }
        return comment;
    };
    var addComment = function (data){
        var comment = generateComment(data);
        $.ajax({
            url: ctx + "/member/add-comment",
            data: JSON.stringify(comment),
            type: "POST",

            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "application/json");
                xhr.setRequestHeader("Content-Type", "application/json");
            },
            success: function(newsData) {
                console.log(newsData);
            }
        });

        return data;
    };

    var editComment = function (data){
        var comment = generateComment(data);
        $.ajax({
            url: ctx + "/member/edit-comment",
            data: JSON.stringify(comment),
            type: "PUT",

            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "application/json");
                xhr.setRequestHeader("Content-Type", "application/json");
            },
            success: function(newsData) {
                console.log(newsData);
            }
        });

        return data;
    };

    var deleteComment = function(data){
        var comment = generateComment(data);
        $.ajax({
            url: ctx + "/member/delete-comment",
            data: JSON.stringify(comment),
            type: "DELETE",

            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "application/json");
                xhr.setRequestHeader("Content-Type", "application/json");
            },
            success: function(newsData) {
                console.log(newsData);
            }
        });
    }

    var uploadAttachementComment = function(dataArray){
        var comment;
        $(dataArray).each(function(index, commentJSON) {
            var formData = new FormData();
            formData.append("objId",objId);
            $(Object.keys(commentJSON)).each(function(index, key) {
                var value = commentJSON[key];
                if(value) formData.append(key, value);
            });
            $.ajax({
                url: ctx + '/member/add-comment-with-file',
                type: 'POST',
                data: formData,
                enctype: 'multipart/form-data',
                processData: false,
                contentType:false,
                success: function(commentJSON) {
                    console.log(commentJSON);
                },
                error: function(data) {
                    console.log(data);
                },
            });
        });
        return dataArray;
    };

    $('#comments-container').comments({
        profilePictureURL: 'https://viima-app.s3.amazonaws.com/media/user_profiles/user-icon.png',
        currentUserId: userId,
        roundProfilePictures: true,
        textareaRows: 1,
        enableAttachments: true,
        enableHashtags: true,
        enablePinging: true,
        getUsers: function(success, error) {
            success(usersArray);
        },
        getComments: function(success, error) {
            success(commentsArray);
        },
        postComment: function(data, success, error) {
            success(addComment(data));
        },
        putComment: function(data, success, error) {
            success(editComment(data));
        },
        deleteComment: function(data, success, error) {
            success(deleteComment(data));
        },
        upvoteComment: function(data, success, error) {
            success(editComment(data));
        },
        uploadAttachments: function(dataArray, success, error) {
            success(uploadAttachementComment(dataArray));
        },
    });
});
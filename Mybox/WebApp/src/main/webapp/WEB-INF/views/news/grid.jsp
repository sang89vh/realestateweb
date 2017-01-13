<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<script type="text/javascript">
	var searchNews = function(prm){
		$.post(ctx + "/map/search-place", prm, function(data) {
			console.log(data);
			showNews(data);
			
		});
	}
	var showNews = function(data){
		var $newsRow = $("#new-row");
		$.each(data,function(index,item){
			var temp=$("#temp-row").find(".item").clone();
			var $img = $(temp.find("img")[0]);
			$img.attr("src",item.thumbs[0]);
			
			var $title = $(temp.find("a")[0]);
			$title.text(item.title)
			
			var $content = $(temp.find("p")[0]);
			$content.html(item.address)
			
			$newsRow.html(temp);
			
			
		})
	}
	$(document).ready(function(){
		var prm ={
			southwestLatitude : 21.027684827936138,
			southwestLongitude : 105.77814722164305,
			northeastLatitude : 21.032691930005605,
			northeastLongitude : 105.79145097835692

		};
		searchNews(prm);
		
	})
	
</script>
<div class="news-container">
	<div class="row" id="new-row"></div>
</div>
<div id="temp-row" style="display: none;">
	<div class="item well">
		<img alt="" src="">
		<a></a>
		<p></p>
	</div>

</div>
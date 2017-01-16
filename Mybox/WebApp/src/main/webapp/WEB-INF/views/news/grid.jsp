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
			<a href="#">
				<img alt="" src="" style="width: 100%;height: auto;">
			</a>
			<b class="price" ></b><br/>
			<span class="info"></span><br/>
			<span class="address"></span><br/>
		</div>
	</div>
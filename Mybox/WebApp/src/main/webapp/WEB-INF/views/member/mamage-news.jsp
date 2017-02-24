<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<style type="text/css">
	#newsTabsContent .tab-pane{
		height: 500px!important;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		   
		$('#newsTabs a:first').tab('show') ;
		
		
		    $("#waiting").jsGrid({
		        height: "90%",
		        width: "100%",
		 
		        filtering: true,
		        editing: true,
		        sorting: true,
		        paging: true,
		        autoload: true,
		 
		        pageSize: 15,
		        pageButtonCount: 5,
		 
		        deleteConfirm: "Do you really want to delete the client?",
		        rowClick: function(args) {
		        	console.log('rowClick');
					//item       // data item
					//itemIndex  // data item index
					//event      // jQuery event
					
            	    console.log(args.item);
            	    console.log(args.itemIndex);
            	    console.log(args.event);
            	    
            	    var url=ctx+"/news/property?obj="+args.item.objectId+"&lat="+args.item.location.latitude+"&lng="+args.item.location.longitude;
            	    var redirectWindow = window.open(url, '_blank');
            	    redirectWindow.location;
            	},
            	onItemEditing: function(args) {
            		console.log('onItemEditing');
            		
            		args.cancel = true;
            		 //grid                // grid instance
            		 //row                 // editing row jQuery element
            		 //item                // editing item
            		 //itemIndex           // editing item index
					
            	    console.log(args.row);
            	    console.log(args.item);
            	    console.log(args.itemIndex);
            	    
            	    window.location.href=ctx+"/member/edit-news/"+args.item.objectId;
                
            	},
		        controller: {
		            loadData: function(filter) {
		            	console.log(filter);
		            	filter.status="WAITING_APPROVAL";
		            	
		                var d = $.Deferred();
		 
		                $.ajax({
		                    url: ctx + "/member/getNews.ajax",
		                    method:"POST",
		                    dataType: "json",
		                    data:filter
		                }).done(function(response) {
		                	console.log(response[0]);
		                    d.resolve(response);
		                });
		 
		                return d.promise();
		            }
		            
		        },
		 
		        fields: [
		            { name: "title", type: "text", title: "Tiêu đề", sorting: true },
		            { name: "createdAtLabel", type: "text", title: "Ngày đăng", sorting: true, width: 5 },
		            { type: "control",width: 5  }
		        ]
		    });
		    
		    
		    $("#live").jsGrid({
		        height: "90%",
		        width: "100%",
		 
		        filtering: true,
		        editing: false,
		        sorting: true,
		        paging: true,
		        autoload: true,
		 
		        pageSize: 15,
		        pageButtonCount: 5,
		 
		        deleteConfirm: "Do you really want to delete the client?",
	            rowClick: function(args) {
					//item       // data item
					//itemIndex  // data item index
					//event      // jQuery event
					
            	    console.log(args.item);
            	    console.log(args.itemIndex);
            	    console.log(args.event);
                
            	},
		        controller: {
		            loadData: function(filter) {
		            	console.log(filter);
		            	filter.status="APPROVED";
		            	
		                var d = $.Deferred();
		 
		                $.ajax({
		                    url: ctx + "/member/getNews.ajax",
		                    method:"POST",
		                    dataType: "json",
		                    data:filter
		                }).done(function(response) {
		                	console.log(response[0]);
		                    d.resolve(response);
		                });
		 
		                return d.promise();
		            }
		        },
		 
		        fields: [
		            { name: "title", type: "text", title: "Tiêu đề", sorting: true },
		            { name: "createdAtLabel", type: "text", title: "Ngày đăng", sorting: true, width: 5 },
		            { type: "control",width: 5  }
		        ]
		    });
		    
		    
		    $("#offline").jsGrid({
		        height: "90%",
		        width: "100%",
		 
		        filtering: true,
		        editing: false,
		        sorting: true,
		        paging: true,
		        autoload: true,
		 
		        pageSize: 15,
		        pageButtonCount: 5,
		 
		        deleteConfirm: "Do you really want to delete the client?",
		 
		        controller: {
		            loadData: function(filter) {
		            	console.log(filter);
		            	filter.status="OFFLINE";
		            	
		                var d = $.Deferred();
		 
		                $.ajax({
		                    url: ctx + "/member/getNews.ajax",
		                    method:"POST",
		                    dataType: "json",
		                    data:filter
		                }).done(function(response) {
		                	console.log(response[0]);
		                    d.resolve(response);
		                });
		 
		                return d.promise();
		            }
		        },
		 
		        fields: [
		            { name: "title", type: "text", title: "Tiêu đề", sorting: true },
		            { name: "createdAtLabel", type: "text", title: "Ngày đăng", sorting: true, width: 5 }
		        ]
		    });
		 
	})

</script>
<div class="bs-news bs-news-tabs" data-example-id="togglable-tabs">
	<ul class="nav nav-tabs" id="newsTabs" role="tablist">
		<li role="presentation" class="active">
			<a href="#waiting" id="waiting-tab"
				role="tab" data-toggle="tab" aria-controls="waiting"
				aria-expanded="true">Chờ duyệt</a>
		</li>
		<li role="presentation" class="">
			<a href="#live" role="tab"
			id="live-tab" data-toggle="tab" aria-controls="live"
			>Đang đăng</a>
		</li>
		<li role="presentation" class="">
			<a href="#offline" role="tab"
			id="offline-tab" data-toggle="tab" aria-controls="offline"
			>Hết hạn</a>
		</li>
	</ul>
	<div class="tab-content" id="newsTabsContent">
		<div class="tab-pane fade in active" role="tabpanel" id="waiting"
			aria-labelledby="waiting-tab">
			waiting
		</div>
		<div class="tab-pane fade" role="tabpanel" id="live"
			aria-labelledby="live-tab">
			live
		</div>
		<div class="tab-pane fade" role="tabpanel" id="offline"
			aria-labelledby="offline-tab">
			offline
		</div>
		</div>
	</div>
</div>
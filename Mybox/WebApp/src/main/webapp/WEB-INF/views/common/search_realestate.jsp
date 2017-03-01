<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<form id="form-search">
	<div class="row">
		<div class="col-md-5 col-sm-12">
				<div class="form-group">
		        	<div class="input-group" style="width: 100%;">
		            	<input class="form-control" id="search-location-text" type="search" placeholder='Tim dia diem' value='${search}' style="width: 100%;">
		     		</div>
		     	</div>
		 </div>
		 <div class="col-md-7 col-sm-12">      
		 		<div class="form-group" style="width: 100%;"> 	
		            	<select id="type" name ="newType" class="selectpicker" style="width: 150px;" onchange="changeType(this)" style="width: 100%;">
						  <option value=""><spring:message code="NEWS_CATEGORY"/></option>
						  <option value="FOR_RENT_APARTMENT"><spring:message code="FOR_RENT_APARTMENT"/></option>
						  <option value="FOR_RENT_HOUSE"><spring:message code="FOR_RENT_HOUSE"/></option>
						  <option value="FOR_RENT_HOTEL"><spring:message code="FOR_RENT_HOTEL"/></option>
						  <option value="FOR_RENT_HOSTEL"><spring:message code="FOR_RENT_HOSTEL"/></option>
						</select>
						<select id="price" name ="price"  class="selectpicker" style="width: 150px;" onchange="changePrice(this)" style="width: 100%;">
						  <option value=""><spring:message code="SEARCH_PRICE"/></option>
						  <option value="SEARCH_PRICE_200"><spring:message code="SEARCH_PRICE_200"/></option>
						  <option value="SEARCH_PRICE_300"><spring:message code="SEARCH_PRICE_300"/></option>
						  <option value="SEARCH_PRICE_400"><spring:message code="SEARCH_PRICE_400"/></option>
						  <option value="SEARCH_PRICE_500"><spring:message code="SEARCH_PRICE_500"/></option>
						  <option value="SEARCH_PRICE_1000"><spring:message code="SEARCH_PRICE_1000"/></option>
						  <option value="SEARCH_PRICE_2000"><spring:message code="SEARCH_PRICE_2000"/></option>
						  <option value="SEARCH_PRICE_3000"><spring:message code="SEARCH_PRICE_3000"/></option>
						  <option value="SEARCH_PRICE_5000"><spring:message code="SEARCH_PRICE_5000"/></option>
						  <option value="SEARCH_PRICE_8000"><spring:message code="SEARCH_PRICE_8000"/></option>
						</select>
						<select id="numBed" name ="beds"  class="selectpicker" style="width: 150px;" onchange="changeNumBed(this)" style="width: 100%;">
						  <option value=""><spring:message code="SEARCH_BEDS"/></option>
						  <option value="SEARCH_BEDS_1"><spring:message code="SEARCH_BEDS_1"/></option>
						  <option value="SEARCH_BEDS_2"><spring:message code="SEARCH_BEDS_2"/></option>
						  <option value="SEARCH_BEDS_3"><spring:message code="SEARCH_BEDS_3"/></option>
						  <option value="SEARCH_BEDS_4"><spring:message code="SEARCH_BEDS_4"/></option>
						  <option value="SEARCH_BEDS_5"><spring:message code="SEARCH_BEDS_5"/></option>
						  <option value="SEARCH_BEDS_6"><spring:message code="SEARCH_BEDS_6"/></option>
						</select>
		            	
		        </div>
		     </div>
		     <div style="display: none;">
				<div class="form-group">
		            	<div class="input-group-btn">
		                	<span id="search-location" style="width: 100%;"><span class="fui-search"></span></span>
		                </div>
		     	</div>
		 	</div>
	</div>
 </form>
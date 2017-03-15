<%@ include file="/WEB-INF/views/layout/taglib.jsp"%>
<!-- The Modal -->
<div id="locationModal" class="modal center-block">

    <!-- Modal content -->
    <div class="modal-content">
        <div class="modal-header">
            <span class="close" id="closeLocationModal">&times;</span>
            <br/>
        </div>
        <div class="modal-body">
            <p>Please select your location</p>
            <label class="radio">
                <input type="radio" name="locationRadios" id="locationRadio1" value="1" data-toggle="radio" class="custom-radio">
                <span class="icons">
                    <span class="icon-unchecked"></span>
                    <span class="icon-checked"></span>
                </span>
                Ha Noi
            </label>
            <label class="radio">
                <input type="radio" name="locationRadios" id="locationRadio2" value="2" data-toggle="radio" class="custom-radio">
                <span class="icons">
                    <span class="icon-unchecked"></span>
                    <span class="icon-checked"></span>
                </span>
                Ho Chi Minh
            </label>
        </div>
        <%--<div class="modal-footer">--%>
            <%--<h3>Modal Footer</h3>--%>
        <%--</div>--%>
    </div>

</div>
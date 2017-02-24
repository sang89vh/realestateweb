<<<<<<< HEAD
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
     	zoom: 15
     });
	findCurrentPos(true,3);
	prepareSearchLocation(document.getElementById('search-location-text'),true,3);
};

var updateAdminInfo = function(specificAddress,adminAddress,note){
	$("#address").val(specificAddress);
	var str = "phường " + adminAddress.ward
			+ ", quận " + adminAddress.district
			+ ", thành phố " + adminAddress.city
	$("#posAdminDetail").html(str);
	$("#posLatLng").html(note);
}


var paths = [];
//Disabling autoDiscover, otherwise Dropzone will try to attach twice.
Dropzone.autoDiscover = false;
// or disable for specific dropzone:
// Dropzone.options.myDropzone = false;

$(function() {
  // Now that the DOM is fully loaded, create the dropzone, and setup the
  // event listeners
  var myDropzone = new Dropzone("#my-dropzone", { url: ctx + "/member/uploadImages",addRemoveLinks:true});
  myDropzone.on("addedfile", function(file) {
    /* Maybe display some more file information on your page */
    console.log("adding file");
    console.log(file);
  });
  myDropzone.on("success", function(file,data) {
    /* Maybe display some more file information on your page */
    console.log("adding success");
    file.path=data.path;
    console.log(file.name);
    console.log(data);
    
    paths.push(data.path);
    
  });
  myDropzone.on("removedfile", function(file) {
    /* Maybe display some more file information on your page */
    console.log("removedfile");
    console.log(file);
    var name = file.name;
    console.log(name);
    console.log(file.path);
    paths.splice( paths.indexOf(file.path), 1 );
  });
  $("#my-dropzone").addClass("dropzone");
})
var preSubmitForm = function(btn){
	$("#imageIds").val(paths.toString());
	submitForm(btn);
}
var saveNewsCallback = function(form,data){
	console.log(data);
	window.location.href=ctx+'/member/manage-news';
}


$(document).ready(function(){
	$("#posOption2").change(function(){ 
        if( $(this).is(":checked") ){ 
            console.log($(this).val());
        }
    });
	$("#posOption1").change(function(){ 
        if( $(this).is(":checked") ){ 
            console.log($(this).val());
        }
    });
	
});
=======
/***************************************************************************/
/*                                                                         */
/*  This obfuscated code was created by Javascript Obfuscator Free Version.*/
/*  Javascript Obfuscator Free Version can be downloaded here              */
/*  http://javascriptobfuscator.com                                        */
/*                                                                         */
/***************************************************************************/
var _$_b911=["map","getElementById","Map","maps","search-location-text","val","#addressManual","ph\u01b0\u1eddng ","ward",", qu\u1eadn ","district",", th\xE0nh ph\u1ed1 ","city","html","#posAdminDetail","#posLatLng","autoDiscover","#my-dropzone","/member/uploadImages","addedfile","adding file","log","on","success","adding success","path","name","push","removedfile","indexOf","splice","dropzone","addClass","toString","#imageIds","href","location","/member/manage-news",":checked","is","change","#posOption2","#posOption1","ready"];function initMap(){map=  new google[_$_b911[3]][_$_b911[2]](document[_$_b911[1]](_$_b911[0]),{zoom:15});findCurrentPos(true,3);prepareSearchLocation(document[_$_b911[1]](_$_b911[4]),true,3)}var updateAdminInfo=function(_0x137E4,_0x137B0,_0x137CA){$(_$_b911[6])[_$_b911[5]](_0x137E4);var _0x137FE=_$_b911[7]+ _0x137B0[_$_b911[8]]+ _$_b911[9]+ _0x137B0[_$_b911[10]]+ _$_b911[11]+ _0x137B0[_$_b911[12]];$(_$_b911[14])[_$_b911[13]](_0x137FE);$(_$_b911[15])[_$_b911[13]](_0x137CA)};var paths=[];Dropzone[_$_b911[16]]= false;$(function(){var _0x13818= new Dropzone(_$_b911[17],{url:ctx+ _$_b911[18],addRemoveLinks:true});_0x13818[_$_b911[22]](_$_b911[19],function(_0x13832){console[_$_b911[21]](_$_b911[20]);console[_$_b911[21]](_0x13832)});_0x13818[_$_b911[22]](_$_b911[23],function(_0x13832,_0x1384C){console[_$_b911[21]](_$_b911[24]);_0x13832[_$_b911[25]]= _0x1384C[_$_b911[25]];console[_$_b911[21]](_0x13832[_$_b911[26]]);console[_$_b911[21]](_0x1384C);paths[_$_b911[27]](_0x1384C[_$_b911[25]])});_0x13818[_$_b911[22]](_$_b911[28],function(_0x13832){console[_$_b911[21]](_$_b911[28]);console[_$_b911[21]](_0x13832);var _0x13866=_0x13832[_$_b911[26]];console[_$_b911[21]](_0x13866);console[_$_b911[21]](_0x13832[_$_b911[25]]);paths[_$_b911[30]](paths[_$_b911[29]](_0x13832[_$_b911[25]]),1)});$(_$_b911[17])[_$_b911[32]](_$_b911[31])});var preSubmitForm=function(_0x13880){$(_$_b911[34])[_$_b911[5]](paths[_$_b911[33]]());submitForm(_0x13880)};var saveNewsCallback=function(_0x1389A,_0x1384C){console[_$_b911[21]](_0x1384C);window[_$_b911[36]][_$_b911[35]]= ctx+ _$_b911[37]};$(document)[_$_b911[43]](function(){$(_$_b911[41])[_$_b911[40]](function(){if($(this)[_$_b911[39]](_$_b911[38])){console[_$_b911[21]]($(this)[_$_b911[5]]())}});$(_$_b911[42])[_$_b911[40]](function(){if($(this)[_$_b911[39]](_$_b911[38])){console[_$_b911[21]]($(this)[_$_b911[5]]())}})});var paths=[];Dropzone[_$_b911[16]]= false;$(function(){var _0x13818= new Dropzone(_$_b911[17],{url:ctx+ _$_b911[18],addRemoveLinks:true});_0x13818[_$_b911[22]](_$_b911[19],function(_0x13832){console[_$_b911[21]](_$_b911[20]);console[_$_b911[21]](_0x13832)});_0x13818[_$_b911[22]](_$_b911[23],function(_0x13832,_0x1384C){console[_$_b911[21]](_$_b911[24]);_0x13832[_$_b911[25]]= _0x1384C[_$_b911[25]];console[_$_b911[21]](_0x13832[_$_b911[26]]);console[_$_b911[21]](_0x1384C);paths[_$_b911[27]](_0x1384C[_$_b911[25]])});_0x13818[_$_b911[22]](_$_b911[28],function(_0x13832){console[_$_b911[21]](_$_b911[28]);console[_$_b911[21]](_0x13832);var _0x13866=_0x13832[_$_b911[26]];console[_$_b911[21]](_0x13866);console[_$_b911[21]](_0x13832[_$_b911[25]]);paths[_$_b911[30]](paths[_$_b911[29]](_0x13832[_$_b911[25]]),1)});$(_$_b911[17])[_$_b911[32]](_$_b911[31])});var preSubmitForm=function(_0x13880){$(_$_b911[34])[_$_b911[5]](paths[_$_b911[33]]());submitForm(_0x13880)};var saveNewsCallback=function(_0x1389A,_0x1384C){console[_$_b911[21]](_0x1384C);window[_$_b911[36]][_$_b911[35]]= ctx+ _$_b911[37]};$(document)[_$_b911[43]](function(){$(_$_b911[41])[_$_b911[40]](function(){if($(this)[_$_b911[39]](_$_b911[38])){console[_$_b911[21]]($(this)[_$_b911[5]]())}});$(_$_b911[42])[_$_b911[40]](function(){if($(this)[_$_b911[39]](_$_b911[38])){console[_$_b911[21]]($(this)[_$_b911[5]]())}})})
>>>>>>> startup8x/master

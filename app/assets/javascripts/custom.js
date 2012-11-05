// JavaScript Document for Younic
$(window).load(function() {

	//equal height
	if($(window).width() < 767)
	{
	}
	else
	{
		function equalHeight(group) {
			tallest = 0;
			group.each(function() {
				thisHeight = $(this).height();
				if(thisHeight > tallest) {
					tallest = thisHeight;
				}
			});
			group.height(tallest);
		}
		equalHeight($(".equal_columns"));
	}

});

var mouse_is_inside = false;

$(document).ready(function() {

	$(".client_login_btn").click(function() {
		$("#salon_login_box").fadeOut("fast");
		var loginBox = $("#client_login_box");
		if (loginBox.is(":visible")){
			loginBox.fadeOut("fast");
		}else{
			loginBox.fadeIn("fast");
		}
		return false;
	});
	$(".salon_login_btn").click(function() {
		$("#client_login_box").fadeOut("fast");
		var loginBox = $("#salon_login_box");
		if (loginBox.is(":visible")){
			loginBox.fadeOut("fast");
		}else{
			loginBox.fadeIn("fast");
		}
		return false;
	});
	$("#client_login_box").hover(function(){ 
		mouse_is_inside=true; 
	}, function(){ 
		mouse_is_inside=false; 
	});
	$("#salon_login_box").hover(function(){ 
		mouse_is_inside=true; 
	}, function(){ 
		mouse_is_inside=false; 
	});
	$("body").click(function(){
		if(!mouse_is_inside){
			$(".client_login_box, .salon_login_box").fadeOut("fast");	
		} 
	});
}); //close document.ready
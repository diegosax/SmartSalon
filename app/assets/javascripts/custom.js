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

// image slider
$('.slider-image').flexslider({
	animation: "fade",
	slideshowSpeed: 4000,
	animationDuration: 1000,
	controlNav: false,
	keyboardNav: true,
	directionNav: true,
	pauseOnHover: true,
	pauseOnAction: true    
});

//testimonial slider
$('.slider-testimonial').flexslider({
	animation: "fade",
	slideshowSpeed: 7000,
	animationDuration: 200,
	controlNav: true,
	keyboardNav: true,
	directionNav: false,
	pauseOnHover: true,
	pauseOnAction: true    
});	

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

//Contact form
$(function() {
	var v = $("#contactform").validate({
		submitHandler: function(form) {
			$(form).ajaxSubmit({
				target: "#result",
				clearForm: true
			});
		}
	});
});
//To clear form field on page refresh
$('#contactform #message').val('');

//Subscribe form
$(function() {
	var v = $("#subform").validate({
		submitHandler: function(form) {
			$(form).ajaxSubmit({
				target: "#result_sub",
				clearForm: true
			});
		}
	});

});

}); //close document.ready


// Below scripts do not require modification

/* IE Image Resizing - by Ethan Marcotte - http://unstoppablerobotninja.com/entry/fluid-images/ */
var imgSizer = {
	Config : {
		imgCache : []
		,spacer : "/assets/spacer.gif"
	}

	,collate : function(aScope) {
		var isOldIE = (document.all && !window.opera && !window.XDomainRequest) ? 1 : 0;
		if (isOldIE && document.getElementsByTagName) {
			var c = imgSizer;
			var imgCache = c.Config.imgCache;

			var images = (aScope && aScope.length) ? aScope : document.getElementsByTagName("img");
			for (var i = 0; i < images.length; i++) {
				images[i].origWidth = images[i].offsetWidth;
				images[i].origHeight = images[i].offsetHeight;

				imgCache.push(images[i]);
				c.ieAlpha(images[i]);
				images[i].style.width = "100%";
			}

			if (imgCache.length) {
				c.resize(function() {
					for (var i = 0; i < imgCache.length; i++) {
						var ratio = (imgCache[i].offsetWidth / imgCache[i].origWidth);
						imgCache[i].style.height = (imgCache[i].origHeight * ratio) + "px";
					}
				});
			}
		}
	}

	,ieAlpha : function(img) {
		var c = imgSizer;
		if (img.oldSrc) {
			img.src = img.oldSrc;
		}
		var src = img.src;
		img.style.width = img.offsetWidth + "px";
		img.style.height = img.offsetHeight + "px";
		img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='scale')"
		img.oldSrc = src;
		img.src = c.Config.spacer;
	}

	// Ghettomodified version of Simon Willison's addLoadEvent() -- http://simonwillison.net/2004/May/26/addLoadEvent/
	,resize : function(func) {
		var oldonresize = window.onresize;
		if (typeof window.onresize != 'function') {
			window.onresize = func;
		} else {
			window.onresize = function() {
				if (oldonresize) {
					oldonresize();
				}
				func();
			}
		}
	}
}

